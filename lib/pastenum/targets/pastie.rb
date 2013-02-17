#Internal search implementation for pastie.org (deprecated, migrate to Gscraper)
module Pastenum
  class Pastie < Target
    
    def initialize(dork)
      @dork = URI.escape(dork)
      @agent = Mechanize.new
      @results = Array.new
      @vendor = "pastie.org"
      super
    end

    def search
      print "[*] Parsing pages:".green if @verbose
      current_page = 1
      page_numbers.times do
        print ".".green if @verbose
        page = @agent.get("http://pastie.org/search?&commit=Start+Search&page=#{current_page}&q=#{@dork}")
        page.links.each do |link|
          if link.href.match(/pastie\.org\/pastes/)
            @results << link.href
          end
        end
        current_page += 1
      end
      puts "\n" if @verbose
      return @results.uniq!
    end
  
    private
  
    def page_numbers
      puts "[*] Getting Results".green
      begin
        results = @agent.get("http://pastie.org/search?&commit=Start+Search&page=1&q=#{@dork}")
      rescue
        raise TargetUnreachable, "[!] ERROR: Can not load pastie.org - Check Connectivity"
      end
      puts "[*] Searching Pastie.org (Limit: 1000 Results)".green if @verbose
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
  
  end
end