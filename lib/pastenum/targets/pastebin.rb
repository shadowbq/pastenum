#Google sitesearch for pastebin using GScraper
module Pastenum
  class Pastebin < Target
    
    attr_accessor :enabled, :max_pages
    attr_reader :dork, :results
      
    def initialize(dork)
      @enabled = true
      @dork = dork
      @max_pages = 25
      @results = Array.new
      @vendor = "pastebin.com"
    end
  
    def search
      if @enabled
        puts "[*] Searching Pastebin.com (Limit: First #{@max_pages} Pages)".green
        
        q = GScraper::Search.query(:query => @dork, :site => 'pastebin.com')
        
        print "[*] Parsing pages: ".green
        begin
          for i in 1..@max_pages do
            print ".".green
            page = q.page(i)
            page.each do |result|
              result_url = result.url
              url2 = result_url.to_s.split("&").first
              url3 = url2.split("=").last
              url4 = url3.split("/").last
              if url4.length == 8
                if 
                  @results.include?(url4) == true
                else
                  @results << url4
                end
              end
            end
          end
        rescue
          puts "\n[!] ERROR: Maybe the googles banned you?".red
          raise TargetUnreachable, "google search unreachable"
        end
        
        puts "\n"
      end
    
      return @results
    end
  end
end  