IRB.conf[:AUTO_INDENT] = true
begin
  require 'irb/completion'
  require 'irb/ext/save-history'
  puts "IRB initialized!"
rescue LoadError => err
  $stderr.puts "Couldn't initialize IRB: #{err}"
end
