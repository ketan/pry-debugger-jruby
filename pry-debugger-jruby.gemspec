lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'pry-debugger-jruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'pry-debugger-jruby'
  spec.version       = PryDebuggerJRuby::VERSION
  spec.platform      = 'java'
  spec.author        = 'Ivo Anjo'
  spec.email         = 'ivo.anjo@ist.utl.pt'
  spec.license       = 'MIT'
  spec.homepage      = 'https://github.com/ivoanjo/pry-debugger-jruby'
  spec.summary       = 'JRuby 9k-compatible pry debugging!'
  spec.description   = "Add a JRuby-compatible debugger to 'pry'. Adds 'step', 'next', and 'continue' commands to control execution."

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_runtime_dependency 'pry', '>= 0.10', '< 0.12'
  spec.add_runtime_dependency 'ruby-debug-base', '~> 0.10.4'

  spec.add_development_dependency 'pry-remote', '~> 0.1.6'
  spec.add_development_dependency 'rake', '~> 11.3'
end
