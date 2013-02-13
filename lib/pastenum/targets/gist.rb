# Internal Gist Gist.github Search 
module Pastenum
  class Gist < Target

    def initialize(dork)
      @enabled = 1 #1 is enabled, 0 is disabled
      @dork = URI.escape(dork)
      @agent = Mechanize.new
      @max_pages = 25
    end

    def search
      unless @enabled == 0
        start_page = 1
        pages = page_numbers.to_i
        addresses_gist = []
        print "[*] Parsing pages:".green
        pages.times do
          print ".".green
          results = @agent.get("https://gist.github.com/search?page=#{start_page}&q=#{@dork}")
            results.links.each do |link|   
              if link.text.match(/\s\/\s/)
                address = link.href
                  if 
                    addresses_gist.include?(address) == true
                  else
                    addresses_gist << address
                  end
              end
          end
          start_page += 1
        end
      end
      return addresses_gist
    end
  
    private 
  
    def page_fetch(page_num)
      begin
        @results = @agent.get("https://gist.github.com/search?page=#{page_num}&q=#{@dork}")
      rescue
        puts "[!] ERROR: Can not load gist.github - Check Connectivity".red
        exit
      end
    end
    
    def page_numbers
      page_num = 1
      next_page = true
      puts "[*] Searching Gist - This is a little slow, Be patient".green
      page_count = []
      while next_page == true
        page_fetch(page_num)
        @results.links.each do |link|
          if link.href.match(/\/search\?page\=/)
            if link.text.match(/Next/)
              next_page = true
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