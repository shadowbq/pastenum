#Google sitesearch for pastebin using GScraper
module Pastenum
  class Pastebin < Target
    
    def initialize(dork)
      @dork = dork
      @vendor = "pastebin.com"
      @raw_url = "http://pastebin.com/raw.php?i="
      
      super
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
            url = result.url.to_s.split("&").first.split("=").last
            # url -> "http://pastebin.com/E7SmXKMs"
            code = url.split("/").last
            # code -> "E7SmXKMs"
            if code.length == 8
              @results << code
            end
          end
        end
      rescue
        raise TargetUnreachable, "[!] ERROR: Google search unreachable , Maybe the googles banned you?"
      end
      puts "\n" if @verbose
      return @results.uniq!  
    end

  end
end  