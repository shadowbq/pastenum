module Pastenum
  class Target
    # attr_accessor :enabled, :dork

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
        puts "[!] No Items Found on #{@vendor}, Try Harder".red
      else
        puts "[*] Total Items found on #{@vendor}: #{@results.count}".green
      end
    end
    
  end
end