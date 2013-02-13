require 'optparse'
require 'pastenum'
require 'colored'


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
    @pastie = Pastenum::Pastie.new(dork)
    @pastie.search
    @pastie.summary
    
    @pastebin = Pastenum::Pastebin.new(dork)
    @pastebin.search
    @pastebin.summary
    
    @github = Pastenum::Github.new(dork)
    @github.search
    @github.summary
    
    @gist = Pastenum::Gist.new(dork)
    @gist.search
    @gist.summary


    Pastenum::Report.new(dork, @pastie.results, @pastebin.results, @github.results, @gist.results).to_file
  end
end