module Pastenum
  class Target
    
    attr_accessor :max_pages, :verbose, :raw
    attr_reader :dork, :results, :vendor, :raw_url

    def initialize(search_string)
      @dork ||= search_string
      
      @vendor ||= "TargetTemplate"
      @raw_url ||= "TargetRawTemplate"
      
      @results ||= Array.new
      @agent ||= Mechanize.new
      
      @raw ||= Pastenum::Defaults::Raw
      @verbose ||= Pastenum::Defaults::Verbose
      
      @max_pages ||= Pastenum::Defaults::MaxPages
    end
    
    def verify_ssl_mode
      @agent.verify_mode
    end
    
    def verify_ssl_mode=(mode)
      @agent.verify_mode = mode
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