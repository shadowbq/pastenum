#STDLIBS
require 'uri'
require 'rubygems'

# RubyGems
require 'mechanize'
require 'uri/query_params'
require 'gscraper'
require 'colored'

# Internal 
module Pastenum
  $:.unshift(File.dirname(__FILE__))
  require 'pastenum/main'
  require 'pastenum/report'
  require 'pastenum/json'
  require 'pastenum/version'
  require 'pastenum/target'
  require 'pastenum/targets/gist'
  require 'pastenum/targets/github'
  require 'pastenum/targets/pastie'
  require 'pastenum/targets/pastebin'
end