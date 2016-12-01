require 'pry' unless defined? Pry
require 'pry-debugger-jruby/processor'

class << Pry
  alias start_without_pry_debugger start
  attr_reader :processor

  def start_with_pry_debugger(target = TOPLEVEL_BINDING, options = {})
    @processor ||= PryDebuggerJRuby::Processor.new

    if target.is_a?(Binding) && PryDebuggerJRuby.check_file_context(target)
      # Wrap the processer around the usual Pry.start to catch navigation
      # commands.
      @processor.run(true) do
        start_without_pry_debugger(target, options)
      end
    else
      # No need for the tracer unless we have a file context to step through
      start_without_pry_debugger(target, options)
    end
  end
  alias start start_with_pry_debugger
end
