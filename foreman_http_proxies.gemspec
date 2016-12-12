require File.expand_path('../lib/foreman_http_proxies/version', __FILE__)
require 'date'

# rubocop:disable Rails/Date:
Gem::Specification.new do |s|
  s.name        = 'foreman_http_proxies'
  s.version     = ForemanHttpProxies::VERSION
  s.date        = Date.today.to_s
  s.authors     = ['Foreman team']
  s.email       = ['foreman-dev@googlegroups.com']
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of ForemanHttpProxies.'
  # also update locale/gemspec.rb
  s.description = 'TODO: Description of ForemanHttpProxies.'

  s.files = Dir['{app,config,db,lib,locale}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'deface'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rdoc'
end
