#Internal www.github.com search scraper (Code Type)

# Original pastenum enumerated the repo, we actually want the file.

# Standard result part 1 
# https://github.com/ryuzee/PHPMyScrum

# Standard result part 2 (blob) 
# https://github.com/ryuzee/PHPMyScrum/blob/71dc45c31220bfa04057f9c65a7dfbc046871fa6/.box

# Raw url
# https://raw.github.com/ryuzee/PHPMyScrum/71dc45c31220bfa04057f9c65a7dfbc046871fa6/.box
module Pastenum
  class Github < Target
    
    def initialize(dork)
      @dork = URI.escape(dork)
      @vendor = "https://github.com/"
      @raw_url = "https://raw.github.com/gist/"
      
      super
    end

    def search
      puts "[*] Searching Github".green if @verbose
      current_page = 1
      page_numbers.times do
        print ".".green if @verbose
        page = @agent.get("https://github.com/search?langOverride=&language=&q=#{@dork}&repo=&start_value=#{current_page}&type=Code&x=21&y=22")
        page.links.each do |link|
          if link.href.match(/\/blob/)
            if @raw
              matchdata = link.href.match(/([a-zA-Z0-9\-_\.]+\/[a-zA-Z0-9\-_\.]+)\/(blob)\/([a-z0-9]+)/)
              address = "https://raw.github.com/#{matchdata[1]}/#{matchdata[3]}/"
              @results << address
            else
              @results << "https://github.com#{link.href.split("#").first}"
            end
          end
          current_page += 1
        end
      end
      puts "\n" if @verbose
      return @results.uniq! 
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
        return @max_pages
      else
        return page_count.max
      end
    end
  
  end
end  