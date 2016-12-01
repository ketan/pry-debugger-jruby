require 'rubygems'

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

  # Reference to currently running pry-remote server. Used by the processor.
  attr_accessor :current_remote_server
end
