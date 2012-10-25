# -*- encoding: utf-8 -*-
require File.expand_path('../lib/i18n_inspector/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Maciej Dubiński"]
  gem.email         = ["maciek@dubinski.net"]
  gem.description   = %q{A tool that helps locate untranslated dictionary keys.}
  gem.summary       = %q{A tool that helps locate untranslated dictionary keys.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "i18n_inspector"
  gem.require_paths = ["lib"]
  gem.version       = I18nInspector::VERSION
  gem.add_development_dependency "rspec"
end
