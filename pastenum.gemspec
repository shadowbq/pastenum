$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
name = "pastenum"
require "#{name}/version"

Gem::Specification.new name, Pastenum::VERSION do |s|
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Search Pastebins for content, fork from nullthreat corelan pastenum2"
  s.authors     = ["nullthreat", "shadowbq"]
  s.email       = ["shadowbq@github.com"]
  s.homepage    = "http://github.com/shadowbq/#{name}"
  s.files       = `git ls-files`.split("\n")
  s.license     = 'MIT'
  
  s.required_rubygems_version = ">= 1.8.1"
  
  s.executables = ["pastenum"]
end
