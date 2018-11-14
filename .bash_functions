# vim: ft=sh

lexport() {
  if [[ ! -f "./.env" ]]; then
    echo ".env file does NOT exists ..."
  else
    export $(cat "./.env" | grep -v "^#" | grep -v "^\s*$" | grep -v "^#");
  fi
}

lexport_by_dir() {
  local dir='.env'
  local file='default'
  if [[ -n $1 && -f "$dir/$1" ]]; then
    file="$1"
  fi
  if [[ ! -f "$dir/$file" ]]; then
    echo "$dir/$file does NOT exists ..."
  else
    export $(cat "$dir/$file" | grep -v "^#" | grep -v "^\s*$");
  fi
}

# cd into matching gem directory
cdgem() {
  local gempath=$(gem env gemdir)/gems
  if [[ $1 == "" ]]; then
    cd $gempath
    return
  fi

  local gem=$(ls $gempath | grep -i $1 | sort | tail -1)
  if [[ $gem != "" ]]; then
    cd $gempath/$gem
  fi
}
_cdgem() {
  COMPREPLY=($(compgen -W '$(ls `gem env gemdir`/gems)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0;
}
complete -o default -o nospace -F _cdgem cdgem;

# Encode the string into "%xx"
urlencode() {
  ruby -e 'puts ARGV[0].split(/%/).map{|c|"%c"%c.to_i(16)} * ""' $1
}

# Decode a urlencoded string ("%xx")
urldecode() {
  ruby -r cgi -e 'puts CGI.unescape ARGV[0]' $1
}

b64encode() {
  ruby -e 'puts ARGV[0].unpack("m")[0]'
}

b64decode() {
  ruby -e 'puts ARGV[0].pack("m").gsub(/\s/, "")'
}

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo "${ref#refs/heads/}"
}

function merge() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
  then
    branch=$(current_branch)
    if [[ $branch == 'master' ]]
    then
      echo "This command cannot be run from the master branch"
      return 1
    else
      git checkout master && \
        git pull origin master --ff-only && \
        git checkout "$branch" && \
        git diff-index --quiet --cached HEAD && \
        git rebase master && \
        git diff-index --quiet --cached HEAD && \
        git push origin "$branch":"$branch" --force-with-lease && \
        git checkout master && \
        git merge - --ff-only && \
        git checkout master && \
        git push origin master:master && \
        git push origin ":$branch" && \
        git branch -d "$branch"
    fi
  else
    echo "This command must be run within a git repository"
    return 1
  fi
}
