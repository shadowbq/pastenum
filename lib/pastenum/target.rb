module Pastenum
  class Target
    
    attr_accessor :max_pages, :verbose
    attr_reader :dork, :results, :vendor

    def initialize(dork_url)
      @dork = dork_url
      @vendor = "TargetTemplate"
      @results = Array.new
    end

    def search
      raise TargetTemplateErrorDirectCall
    end
    
    def summary
      if results.count == 0
        puts "[!] No Items Found on #{@vendor}, Try Harder".red if @verbose
      else
        puts "[*] Total Items found on #{@vendor}: #{@results.count}".green if @verbose
      end 
    end
    
  end
end