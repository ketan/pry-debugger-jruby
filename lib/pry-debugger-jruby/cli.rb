# Pry's new plugin loading system ensures this file runs before pry-remote. So
# attempting to load everything directly from lib/pry-debugger-jruby.rb and
# referencing that here causes a circular dependency when running
# bin/pry-remote.
#
# So delay loading our monkey-patch to when someone explicity does a:
#
#   require 'pry-debugger-jruby'
#
# Load everything else here.
#

require 'pry-debugger-jruby/base'
require 'pry-debugger-jruby/pry_ext'
require 'pry-debugger-jruby/commands'
