require 'irb/completion'
require 'rubygems'
require 'what_methods'
require 'ap'

begin
  require 'looksee'
rescue Exception
end

#require 'wirble'

if defined?(Wirble) && Wirble.respond_to?(:colorize)
  Wirble.colorize
end
