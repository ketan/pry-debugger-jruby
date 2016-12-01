require 'pry-debugger-jruby/cli'
require 'pry-debugger-jruby/version'

# Load pry-remote monkey patches if pry-remote's available
begin
  require 'pry-debugger-jruby/pry_remote_ext'
rescue LoadError
end
