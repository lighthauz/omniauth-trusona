# frozen_string_literal: true

require_relative 'lib/omniauth-trusona/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-trusona'
  spec.version       = OmniAuth::Trusona::VERSION
  spec.authors       = ['Tom Piscitell']
  spec.email         = ['tom@trusona.com']

  spec.summary       = 'OmniAuth Strategies for Trusona'
  spec.description   = 'A collection of custom OmniAuth Strategies to make integrating with Trusona easier'
  spec.homepage      = 'https://github.com/trusona/omniauth-trusona'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('json-jwt', '~> 1.13')
  spec.add_dependency('omniauth-oauth2', '~> 1.7')
  spec.add_dependency('omniauth-rails_csrf_protection', '~> 0.1')
  spec.add_dependency('omniauth', '~> 1.9')

  spec.add_development_dependency('guard', '~> 2.16')
  spec.add_development_dependency('guard-rspec', '~> 4.7')
  spec.add_development_dependency('guard-rubocop', '~> 1.0')
  spec.add_development_dependency('rspec', '~> 3.10')
  spec.add_development_dependency('rubocop', '~> 1.3')
end
