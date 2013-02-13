#!/usr/bin/env ruby

begin
  require 'rubygems'
  require 'bundler'
  Bundler.setup(:default)
rescue ::Exception => e
end

# Executable with absolute path to lib for hacking and development
require File.join(File.dirname(__FILE__), '..', 'lib', 'pastenum', 'cli')

Pastenum::CLI.invoke
