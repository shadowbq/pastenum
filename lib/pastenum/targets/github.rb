#Internal www.github.com search scraper
module Pastenum
  class Github < Target
    
    def initialize(dork)
      @dork = URI.escape(dork)
      @agent = Mechanize.new
      @max_pages = 25
      @results = Array.new
      @vendor = "github.com"
    end

    def search
      puts "[*] Searching Github".green if @verbose
      current_page = 1
      page_numbers.times do
        print ".".green if @verbose
        page = @agent.get("https://github.com/search?langOverride=&language=&q=#{@dork}&repo=&start_value=#{current_page}&type=Code&x=21&y=22")
        page.links.each do |link|
          if link.text.match(/\//)
            address = "https://github.com#{link.href}"
            @results << address unless @results.include?(address)
          end
          current_page += 1
        end
      end
      puts "\n" if @verbose
      return @results
    end
  
    private
  
    def page_numbers
      print "[*] Parsing pages:".green if @verbose
      
      print "#".green if @verbose
      
      begin
        page = @agent.get("http://github.com/search?langOverride=&language=&q=#{@dork}&repo=&start_value=1&type=Code&x=21&y=22")
      rescue
        raise TargetUnreachable, "[!] ERROR: Can not load github - Check Connectivity"
      end
    
      page_count = []
      
      page.links.each do |link|
        if link.href.match(/search\?langOverride/)
          pagenum = link.text
          if pagenum.match(/\d/)
            page_count << pagenum.to_i
          end
        else
        end
      end
      
      if page_count.max > @max_pages
        #puts "[*] #{page_count.max} pages of results found.".green
        #puts "[*] Getting the first #{@max_pages} pages".green
        return @max_pages
      else
        #puts "[*] #{page_count.max} pages of results found.".green
        return page_count.max
      end
    end
  
  end
end  