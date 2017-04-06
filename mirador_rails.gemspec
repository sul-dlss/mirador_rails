# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mirador_rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'mirador_rails'
  spec.version       = MiradorRails::VERSION
  spec.authors       = ['Jack Reed']
  spec.email         = ['phillipjreed@gmail.com']

  spec.summary       = %q{Bundling up Mirador for Rails use.}
  spec.description   = %q{Bundling up Mirador for Rails use.}
  spec.homepage      = 'https://github.com/sul-dlss/mirador_rails'
  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'font-awesome-rails'
  spec.add_dependency 'material_icons'
  spec.add_dependency 'openseadragon'
  spec.add_dependency 'jquery-rails'
  spec.add_dependency 'tinymce-rails'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rubyzip'
end
