# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redmine_refresh/version'

Gem::Specification.new do |spec|
  spec.name          = "redmine_refresh"
  spec.version       = RedmineRefresh::VERSION
  spec.authors       = ["Jean-Baptiste Barth"]
  spec.email         = ["jeanbaptiste.barth@gmail.com"]
  spec.description   = %q{Adds an automatic refresh option to Redmine's issues list}
  spec.summary       = %q{Adds an automatic refresh option to Redmine's issues list}
  spec.homepage      = "https://github.com/jbbarth/redmine_refresh"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "deface"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
