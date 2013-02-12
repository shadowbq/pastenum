load 'lib/paste_report.rb'

require 'rubygems'
require 'mechanize'
require 'uri'
require 'uri/query_params'
require 'gscraper'
require 'colored'

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

class Pastebin
  
  def initialize(dork)
    @enabled = 1 #1 is enabled, 0 is disabled
    @dork = dork
    @max_pages = 25
  end
  
  def search
    unless @enabled == 0
      puts "[*] Searching Pastebin.com (Limit: First #{@max_pages} Pages)".green
      $addresses_pastebin = []
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
                $addresses_pastebin.include?(url4) == true
              else
                $addresses_pastebin << url4
              end
            end
          end
        end
      rescue
        puts "\n[!] ERROR: Maybe the googles banned you?".red
      end
      puts "\n"
      if $addresses_pastebin.count == 0
        puts "[!] No Items Found, Try Harder".red
      else
        puts "[*] Total Items found on Pastebin: #{$addresses_pastebin.count}".green
      end
    end
  end
end

class Github

  def initialize(dork_url)
    @enabled = 1 #1 is enabled, 0 is disabled
    @dork = dork_url
    @agent = Mechanize.new
    @max_pages = 25
  end

  def page_numbers
    begin
      results = @agent.get("http://github.com/search?langOverride=&language=&q=#{@dork}&repo=&start_value=1&type=Code&x=21&y=22")
    rescue
      puts "[!] ERROR: Can not load github - Check Connectivity".red
      exit
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
      puts "[*] #{page_count.max} pages of results found.\n[*] Getting the first #{@max_pages} pages".green
      return @max_pages
    else
      puts "[*] #{page_count.max} pages of results found.".green
      return page_count.max
    end
  end

  def search
    unless @enabled == 0
      start_page = 1
      pages = page_numbers.to_i
      $addresses_github = []
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
              $addresses_github.include?(address) == true
            else
              $addresses_github << address
            end
          end
          start_page += 1
        end
      end
    end
  end
end

class Gist

  def initialize(dork_url)
    @enabled = 0 #1 is enabled, 0 is disabled
    @dork = dork_url
    @agent = Mechanize.new
    @max_pages = 25
  end

  def page_retreve(page_num)
    begin
      @results = @agent.get("https://gist.github.com/gists/search?page=#{page_num}&q=#{@dork}&x=12&y=23")
    rescue
      puts "[!] ERROR: Can not load github - Check Connectivity".red
      exit
    end
  end
    
  def page_numbers
    page_num = 1
    next_page = true
    puts "[*] Searching Gist - This is a little slow, Be patient".green
    page_count = []
    while next_page == true
      page_retreve(page_num)
      @results.links.each do |link|
        if link.href.match(/\/gists\/search\?page\=/)
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

  def search
    unless @enabled == 0
      start_page = 1
      pages = page_numbers.to_i
      $addresses_gist = []
      print "[*] Parsing pages:".green
      pages.times do
        print ".".green
        results = @agent.get("https://gist.github.com/gists/search?page=#{start_page}&q=#{@dork}&x=12&y=23")
          results.links.each do |link|   
            if link.text.match(/\s\/\s/)
              address = link.href
                if 
                  $addresses_gist.include?(address) == true
                else
                  $addresses_gist << address
                end
            end
        end
        start_page += 1
      end
    end
  end
end

puts "++++++++++++++++++++++++++++++++++++++++++++++".green
puts "+ Pastie Enum".green
puts "+ A Corelan Team Production - www.corelan.be".green
puts "+ Written by Nullthreat".green
puts "+ Version 2".green
puts "++++++++++++++++++++++++++++++++++++++++++++++\n".green
puts "[?] Input a search string:".green
dork = gets
dork_url = URI.escape(dork)
Pastie.new(dork_url).search
Pastebin.new(dork).search
Github.new(dork_url).search
Gist.new(dork).search
Report.new(dork,$addresses_pastie,$addresses_pastebin,$addresses_github,$addresses_gist).report
