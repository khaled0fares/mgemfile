lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mgemfile/version'

Gem::Specification.new do |spec|
  spec.name          = "mgemfile"
  spec.version       = Mgemfile::VERSION
  spec.authors       = ["khaled0fares"]
  spec.email         = ["kfares29@gmail.com"]

  spec.summary       = %q{CLI manager for Gemfile}
  spec.description   = %q{Add,Remove gem(s) and "bundle install" in a single CLI}
  spec.homepage      = "https://github.com/khaledmohammedfares/mgemfile"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
=begin  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end
=end
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = ["bin"]
  spec.executables   = ["mgemfile"]#spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "thor", "0.19.1"
end
