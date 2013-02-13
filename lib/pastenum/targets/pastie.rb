class Pastie
  def initialize(dork_url)
    @enabled = 1 #1 is enabled, 0 is disabled
    @dork = dork_url
    @agent = Mechanize.new
  end

  def page_numbers
    puts "[*] Getting Results".green
    begin
      results = @agent.get("http://pastie.org/search?&commit=Start+Search&page=1&q=#{@dork}")
    rescue
      puts "[!] ERROR: Can not load pastie.org - Check Connectivity".red
      exit
    end
    puts "[*] Searching Pastie.org (Limit: 1000 Results)".green
    page_count = []
    results.links.each do |link|
      if link.href.match(/pastie.org\/pastes\//)
        page_count << 1
      else
        page_count << 0
      end
      if link.href.match(/Start%2BSearch&page=/)
        uri = link.href
        url = URI("http://pastie.org/search/" + uri)
        page_num = url.query_params['page']
        page_count << page_num.to_i
      end
    end
    page_count.max
  end

  def search
    unless @enabled == 0
      agent = Mechanize.new
      start_page = 1
      pages = page_numbers
      $addresses_pastie = []
      print "[*] Parsing pages:".green
      pages.times do
        print ".".green
        results = @agent.get("http://pastie.org/search?&commit=Start+Search&page=#{start_page}&q=#{@dork}")
        results.links.each do |link|
          if link.href.match(/pastie\.org\/pastes/)
            $addresses_pastie << link.href
          end
        end
      start_page += 1
      end
      puts "\n"
      if $addresses_pastie.count == 0
        puts "[!] No Items Found, Try Harder".red
      else
        puts "[*] Total Items found on Pastie: #{$addresses_pastie.count}".green
      end
    end
  end
end