# Internal Gist Gist.github Search 
module Pastenum
  class Gist < Target
    
    def initialize(dork)
      @dork = URI.escape(dork)
      @vendor = "https://gist.github.com/"
      @raw_url = "https://raw.github.com/gist/"
      
      super
    end

    def search
      puts "[*] Searching Gist".green if @verbose
      current_page = 1
      page_numbers.times do
        print ".".green if @verbose
        page = @agent.get("https://gist.github.com/search?page=#{current_page}&q=#{@dork}")
          page.links.each do |link|   
            if @raw
            # Raw links do not use username only the code            
            # "4556950"
             if link.href.match(/\w+\/([0-9]+)/)
                 @results <<  link.href.match(/\w+\/([0-9]+)/)[1] 
              end
            else 
            # Example Hits to find stad links need username
            # "/shadowbq/4556950"
            # "/shadowbq/2718948"
              if link.href.match(/(\w+\/[0-9]+)/)
                 @results << link.href.match(/(\w+\/[0-9]+)/)[1]
              end
            end
            
        end
        current_page += 1
      end
      
      puts "\n" if @verbose
      return @results.uniq!  #light years faster than array.include X times along with an extra regex match
    end
  
    private 
    
    #TODO: This is very inefficient. This is double fetch reading.  
    def page_numbers
      page_num = 1
      next_page = true
      
      print "[*] Parsing pages:".green if @verbose
      while next_page && page_num < @max_pages

        print "#".green if @verbose
        begin
          page = @agent.get("https://gist.github.com/search?page=#{page_num}&q=#{@dork}")
        rescue
          raise TargetUnreachable, "[!] ERROR: Can not load gist.github - Check Connectivity"
        end
        
        # Find the link with the -> arrow, is it enabled?
        # //div[@class='pagination']
        pagination_parsed = false
        
        page.links.each do |link|
          if link.href.match(/\/search\?page\=/)
            if link.text.match(/#x2192/)
              page_num += 1
            else
              next_page = false
            end
            pagination_parsed = true
          end
        end
        
        #handle single page of results
        next_page = false unless pagination_parsed
        
      end
      
      return page_num
      
    end
  
  end
end  