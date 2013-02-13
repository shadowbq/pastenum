$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
name = "pastenum"
require "#{name}/version"

Gem::Specification.new name, Vendorer::VERSION do |s|
  s.summary = "Search Pastebins for content, fork from nullthreat corelan pastenum2"
  s.authors = ["nullthreat", "Shadowbq"]
  s.email = "shadowbq@github.com"
  s.homepage = "http://github.com/shadowbq/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = 'MIT'
  s.executables = ["pastenum"]
end
