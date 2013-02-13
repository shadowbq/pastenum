#Internal www.github.com search scraper
module Pastenum
  class Github < Target

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
        addresses_github = []
        print "[*] Parsing pages:".green
        pages.times do
          print ".".green
          results = @agent.get("https://github.com/search?langOverride=&language=&q=#{@dork}&repo=&start_value=#{start_page}&type=Code&x=21&y=22")
            results.links.each do |link|
              if link.text.match(/\//)
              address = link.href
              address["tree"] = "raw"
              address = "https://github.com#{address}"
              if 
                addresses_github.include?(address) == true
              else
                addresses_github << address
              end
            end
            start_page += 1
          end
        end
      end
    
      return addresses_github
    
    end
  
    private
  
    def page_numbers
      begin
        results = @agent.get("http://github.com/search?langOverride=&language=&q=#{@dork}&repo=&start_value=1&type=Code&x=21&y=22")
      rescue
        puts "[!] ERROR: Can not load github - Check Connectivity".red
        raise TargetUnreachable, "github unreachable"
      end
      puts "[*] Searching Github".green
      page_count = []
      results.links.each do |link|
        if link.href.match(/search\?langOverride/)
          pagenum = link.text
          if pagenum.match(/\d/)
            page_count << pagenum
          end
        else
        end
      end
      if page_count.max.to_i > @max_pages.to_i
        puts "[*] #{page_count.max} pages of results found.".green
        puts "[*] Getting the first #{@max_pages} pages".green
        return @max_pages
      else
        puts "[*] #{page_count.max} pages of results found.".green
        return page_count.max
      end
    end
  
  end
end  