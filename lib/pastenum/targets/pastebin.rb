class Pastebin < Target
  
  def initialize(dork)
    @enabled = 1 #1 is enabled, 0 is disabled
    @dork = dork
    @max_pages = 25
  end
  
  def search
    unless @enabled == 0
      puts "[*] Searching Pastebin.com (Limit: First #{@max_pages} Pages)".green
      addresses_pastebin = []
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
                addresses_pastebin.include?(url4) == true
              else
                addresses_pastebin << url4
              end
            end
          end
        end
      rescue
        puts "\n[!] ERROR: Maybe the googles banned you?".red
      end
      puts "\n"
      if addresses_pastebin.count == 0
        puts "[!] No Items Found, Try Harder".red
      else
        puts "[*] Total Items found on Pastebin: #{$addresses_pastebin.count}".green
      end
    end
    
    return addresses_pastebin
  end
end