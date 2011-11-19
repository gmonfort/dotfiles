IRB.conf[:AUTO_INDENT] = true
begin
  require 'irb/completion'
  require 'irb/ext/save-history'
  require 'ap'
  require 'wirble'
  Wirble.init
  Wirble.colorize
  puts "IRB initialized!"
rescue LoadError => err
  $stderr.puts "Couldn't initialize IRB: #{err}"
end
