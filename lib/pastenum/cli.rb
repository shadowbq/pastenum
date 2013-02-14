require 'optparse'
require 'pastenum'
require 'colored'


module Pastenum
  class CLI
  
    def self.invoke
      puts "++++++++++++++++++++++++++++++++++++++++++++++".green
      puts "+ Pastie Enum".green
      puts "+ A Corelan Team Production - www.corelan.be".green
      puts "+ Written by Nullthreat".green
      puts "+ Version 2".green
      puts "++++++++++++++++++++++++++++++++++++++++++++++\n".green
      puts "[?] Input a search string:".green
    
      dork = gets
        
      @gist = Pastenum::Gist.new(dork)
      @gist.max_pages = 2
      @gist.search
      @gist.summary
    
      @github = Pastenum::Github.new(dork)
      @github.max_pages = 2
      @github.search
      @github.summary
    
      @pastebin = Pastenum::Pastebin.new(dork)
      @pastebin.max_pages = 2
      @pastebin.search
      @pastebin.summary

      @pastie = Pastenum::Pastie.new(dork)
      #@pastie.max_pages = 2
      @pastie.search
      @pastie.summary



      Pastenum::Report.new(dork, @pastie.results, @pastebin.results, @github.results, @gist.results).to_file
    end

  end
end