#Google sitesearch for pastebin using GScraper
module Pastenum
  class Pastebin < Target
    
    def initialize(dork)
      @dork = dork
      @max_pages = 25
      @results = Array.new
      @vendor = "pastebin.com"
    end
  
    def search
      puts "[*] Searching Pastebin.com (Limit: First #{@max_pages} Pages)".green if @verbose
      q = GScraper::Search.query(:query => @dork, :site => 'pastebin.com')
      print "[*] Parsing pages: ".green if @verbose
      begin
        for i in 1..@max_pages do
          print ".".green if @verbose
          page = q.page(i)
          page.each do |result|
            result_url = result.url
            url2 = result_url.to_s.split("&").first
            url3 = url2.split("=").last
            # url3 -> "http://pastebin.com/E7SmXKMs"
            url4 = url3.split("/").last
            # url4 -> "E7SmXKMs"
            if url4.length == 8
              if 
                @results.include?(url4) == true
              else
                # result.cached_url.to_s
                @results << url4
              end
            end
          end
        end
      rescue
        raise TargetUnreachable, "[!] ERROR: Google search unreachable , Maybe the googles banned you?"
      end
      puts "\n" if @verbose
      return @results
    end

  end
end  