require 'optparse'
require 'highline/import'
require 'pastenum'
require 'colored'
require 'uri'

module Pastenum
  module CLI
    puts "++++++++++++++++++++++++++++++++++++++++++++++".green
    puts "+ Pastie Enum".green
    puts "+ A Corelan Team Production - www.corelan.be".green
    puts "+ Written by Nullthreat".green
    puts "+ Version 2".green
    puts "++++++++++++++++++++++++++++++++++++++++++++++\n".green
    puts "[?] Input a search string:".green
    
    dork = gets

    @pastie = Pastenum::Pastie.new(dork).search
    @pastebin = Pastenum::Pastebin.new(dork).search
    @github = Pastenum::Github.new(dork).search
    @gist = Pastenum::Gist.new(dork).search

    Pastenum::Report.new(dork,$addresses_pastie,$addresses_pastebin,$addresses_github,$addresses_gist).report
  end
end