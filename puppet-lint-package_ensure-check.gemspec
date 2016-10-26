Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-package_ensure-check'
  spec.version     = '0.1.0'
  spec.homepage    = 'https://github.com/danzilio/puppet-lint-package_ensure-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'David Danzilio'
  spec.email       = 'david@danzilio.net'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A puppet-lint plugin to check the ensure attribute on package resources.'
  spec.description = spec.summary

  spec.add_dependency             'puppet-lint', '>= 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end
