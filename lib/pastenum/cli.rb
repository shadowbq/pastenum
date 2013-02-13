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
    @pastie = Pastenum::Pastie.new(dork).search
    
    @pastie.summary
    
    @pastebin = Pastenum::Pastebin.new(dork).search
    
    @pastebin.summary
    
    @github = Pastenum::Github.new(dork).search
    
    @github.summary
    
    @gist = Pastenum::Gist.new(dork).search
    
    @gist.summary


    Pastenum::Report.new(dork, @pastie, @pastebin, @github, @gist).to_file
  end
end