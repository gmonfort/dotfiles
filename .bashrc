if [[ -n "$PS1" ]]; then

    # Global path for cd (no matter which directory you're in right now)
    # export CDPATH=.:~:~/code

    # Keep 3000 lines of history
    export HISTFILESIZE=3000

    # Ignore from history repeat commands, and some other unimportant ones
    export HISTIGNORE="&:[bf]g:c:exit"

    # don't put duplicate lines in the history. See bash(1) for more options
    export HISTCONTROL=ignoredups:ignorespace

    # Ruby development made easier
    export RUBYOPT="rubygems Ilib Itest Ispec"

    # Use vim to browse man pages. One can use Ctrl-[ and Ctrl-t
    # to browse and return from referenced man pages. ZZ or q to quit.
    # NOTE: initially within vim, one can goto the man page for the
    #       word under the cursor by using [section_number]K.
    export MANPAGER='bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" \
        -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

    export EDITOR=vim

    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

    # set current git branch in a variable
    if [ "$(type -t __git_ps1)" = "function" ]; then
        git_branch=$(__git_ps1)
    fi

    eval "`dircolors -b`"

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    xhost +LOCAL:

    # export PYTHONPATH=$PYTHONPATH:/usr/lib/python2.6/dist-packages
    # export CATALINA_HOME=/var/lib/tomcat6
    export HOSTNAME=`/bin/hostname`
    # dh_make variables
    export DEBFULLNAME="German A. Monfort"
    export DEBEMAIL=german.monfort@gmail.com

    export PATH="$PATH:~/bin"

    # External Scripts #

    # Uncomment if you use hitch
    hitch() {
        command hitch "$@"
        if [[ -s "$HOME/.hitch_export_authors" ]]; then
            . "$HOME/.hitch_export_authors";
        fi
    };

    # if [[ $(type -t hitch) == "function" ]]; then hitch; fi
    alias unhitch='hitch -u'

    ################################################################################
    #                                                                              #
    #                                   Functions                                  #
    #                                                                              #
    ################################################################################

    lexport() {
        local dir='.env'
        local file='default'
        if [[ -n $1 && -f "$dir/$1" ]]; then
            file="$1"
        fi
        if [[ ! -f "$dir/$file" ]]; then
          echo "$dir/$file does NOT exists ..."
        else
          export $(cat "$dir/$file")
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

    load_snapshot() {
        local dumpname=${1:-~/dump.sql.gz}
        local config=$(rfind config/database.yml) || { echo "ERROR: could not find 'config/database.yml'" >&2; return 1; }
        local database=$(ruby -ryaml -e "puts YAML.load_file('$config').fetch('development', {}).fetch('database')")

        [[ -e $dumpname ]] || { echo "ERROR: file '$dumpname' does not exist" >&2; return 1; }

        dropdb "$database" && rake db:create && gzip -d < "$dumpname" | psql "$database"
    }

    save_snapshot() {
        local dumpname=${1:-~/dump.sql.gz}
        local config=$(rfind config/database.yml) || { echo "ERROR: could not find 'config/database.yml'" >&2; return 1; }
        local database=$(ruby -ryaml -e "puts YAML.load_file('$config').fetch('development', {}).fetch('database')")

        if [[ -e $dumpname ]]; then
            read -p "file '$dumpname' exists, overwrite? " -n 1
            echo
            [[ $REPLY = [Yy] ]] || return 0
        fi

        pg_dump "$database" | gzip > "$dumpname"
    }

    # Cucumber
    alias rf='rake features'

    # For running specific features.
    function cuke {
        bundle exec cucumber --require features/support --require features/step_definitions "$1"
    }

################################################################################
#                                                                              #
#                                     Prompt                                   #
#                                                                              #
################################################################################

# Prompt in two lines:
#   <hostname> <full path to pwd> (git: <git branch>)
#   ▸
# export PS1='\[\033[01;32m\]\h \[\033[01;33m\]\w$(__git_ps1 " \[\033[01;36m\]\
    #   (git: %s)")\[\033[01;37m\]\n▸\[\033[00m\] '

# PS1='\[\033[01;30m\][ \[\033[01;31m\]\u \[\033[01;30m\]]\[\033[01;34m\]\w\[\033[00m\]\$ '

export PS1='\[\033[01;30m\][ \[\033[01;31m\]\u \[\033[01;30m\]] \[\033[01;33m\]\w $(__git_ps1 "\[\033[01;36m\](git: %s)")\[\033[01;37m\]\n▸\[\033[00m\] '

fi

# RVM ruby version system
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion


# NOTES
#######################################################
# To temporarily bypass an alias, we preceed the command with a \ 
# EG:  the ls command is aliased, but to use the normal ls command you would
# type \ls

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
