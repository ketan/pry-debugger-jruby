require 'rubygems'
require 'java'

module PryDebuggerJRuby
  extend self

  private

  def list_pry_files
    spec = Gem::Specification.find_by_name('pry')

    if spec
      Dir[File.join(spec.gem_dir, '**', '*rb')]
    else
      []
    end
  end

  def list_debugger_files
    Dir[File.join(File.dirname(__FILE__), '..', '**', '*.rb')].map { |f| File.expand_path(f) }
  end

  public

  TRACE_IGNORE_FILES = [*list_debugger_files, *list_pry_files].freeze

  # Checks that a binding is in a local file context. Extracted from
  # https://github.com/pry/pry/blob/master/lib/pry/default_commands/context.rb
  def check_file_context(target)
    file = target.eval('__FILE__')
    file == Pry.eval_path || (file !~ /(\(.*\))|<.*>/ && file != '' && file != '-e')
  end

  def check_trace_enabled
    return true if org.jruby.RubyInstanceConfig.FULL_TRACE_ENABLED
    warn <<-EOS
You are currently running JRuby without the --debug flag enabled, and without it this command will not work correctly.

To fix it, either:

* add the --debug flag to your ruby/jruby command
* or add the --debug flag to the JRUBY_OPTS environment variable
* or enable the jruby.debug.fullTrace option

Do note that having this option on all the time has a performance penalty, so we recommend you only enable it while debugging.
Safe prying, fellow rubyst!
EOS
    false
  end

  # Reference to currently running pry-remote server. Used by the processor.
  attr_accessor :current_remote_server
end
