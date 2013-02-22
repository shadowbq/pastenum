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
  
  s.add_dependency "mechanize",        "~> 2.0"
  s.add_dependency "gscraper",         "~> 0.4"
  s.add_dependency "uri-query_params", "~> 0.7"
  s.add_dependency "colored",          "~> 1.2"
  s.add_dependency "bump",             "~> 0.3"
  s.add_dependency "json",             "~> 1.7"
  s.add_dependency "highline"

end
