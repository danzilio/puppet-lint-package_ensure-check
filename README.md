# puppet-lint-package_ensure-check

[![Build Status](https://img.shields.io/travis/danzilio/puppet-lint-package_ensure-check.svg)](https://travis-ci.org/danzilio/puppet-lint-package_ensure-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-package_ensure-check.svg)](https://rubygems.org/gems/puppet-lint-package_ensure-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-package_ensure-check.svg)](https://rubygems.org/gems/puppet-lint-package_ensure-check)

A puppet-lint plugin to check the ensure attribute on package resources.

## Installing
### From the command line
```shell
$ gem install puppet-lint-package_ensure-check
```

### In a Gemfile
```ruby
gem 'puppet-lint-package_ensure-check'
```

## Checks
### Ensure latest on package resource

The `latest` value for the `ensure` attribute is dangerous and should not be used. You should use `installed` or a version specifier instead.

#### What you have done
```puppet
package { 'puppet':
  ensure => latest,
}
```

#### What you should have done
```puppet
package { 'puppet':
  ensure => '3.8.3-1',
}
```

#### Disabling the check
To disable this check, you can add `--no-package_ensure-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-package_ensure-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_package_ensure')
```

## Fix support
This plugin has the ability to fix the ensure value by setting it to `installed` instead of `latest`.

Only use this if you know what you're doing!
