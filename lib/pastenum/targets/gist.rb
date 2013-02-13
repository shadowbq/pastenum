# Internal Gist Gist.github Search 
module Pastenum
  class Gist < Target
    
    attr_accessor :enabled, :max_pages
    attr_reader :dork, :results
    
    def initialize(dork)
      @enabled = true
      @dork = URI.escape(dork)
      @agent = Mechanize.new
      @max_pages = 25
      @results = Array.new
      @vendor = "gist.github.com"
    end

    def search
      if @enabled
        puts "[*] Searching Gist".green
        
        current_page = 1
        page_numbers.times do
          print ".".green
          page = @agent.get("https://gist.github.com/search?page=#{current_page}&q=#{@dork}")
            page.links.each do |link|   
              if link.text.match(/\s\/\s/)
                 @results << link.href unless @results.include?(link.href)
              end
          end
          current_page += 1
        end
        puts "\n"
      end
      return @results
    end
  
    private 
    
    def page_numbers
      page_num = 1
      next_page = true
      
      print "[*] Parsing pages:".green
      while next_page && page_num < @max_pages
        print "#".green
        begin
          page = @agent.get("https://gist.github.com/search?page=#{page_num}&q=#{@dork}")
        rescue
          puts "[!] ERROR: Can not load gist.github - Check Connectivity".red
          raise TargetUnreachable, "gist.github unreachable"
        end
        
        page.links.each do |link|
          if link.href.match(/\/search\?page\=/)
            if link.text.match(/Next/)
              page_num += 1
            else
              next_page = false
            end
          end
        end
      end
      
      return page_num
      
    end
  
  end
end  