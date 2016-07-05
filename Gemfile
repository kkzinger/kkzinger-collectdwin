source 'https://rubygems.org'
ruby '2.0.0'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.3']
facterversion = ENV.key?('FACTER_VERSION') ? "#{ENV['FACTER_VERSION']}" : ['>= 1.7.0']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper', '>= 0.8.2'
#Enable linting
gem 'puppet-lint', '>= 1.0.0'
gem 'facter', facterversion
#Enable metadata linting
gem 'metadata-json-lint'


