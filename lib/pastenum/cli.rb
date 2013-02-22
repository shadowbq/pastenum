require 'optparse'
require 'pastenum'
require 'colored'
require 'highline/import'

module Pastenum
  class CLI

    def self.invoke
      self.new
    end
    
      
    def initialize  
      options = {}
      
      options[:pastebin] = true
      options[:gist] = true
      options[:github] = true
      options[:pastie] = true
      options[:pastee] = true
      
      options[:raw] = Pastenum::Defaults::Raw
      options[:onion] = false
      options[:test] = false
      options[:verbose] = Pastenum::Defaults::Verbose
      options[:maxpages] = Pastenum::Defaults::MaxPages
      options[:tos] = false
      options[:ssl_verify] = true
      
      opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: pastenum [OPTIONS] \"search string\""
        opt.separator ""
        opt.separator "Sources::"
        
        opt.on("-p","--[no-]pastebin","Search Pastebin.com (Gscraper)","  Default: #{options[:pastebin]}") do |value|
          options[:pastebin] = value
        end
        
        opt.on("-g","--[no-]gist","Search Gist.github.com","  Default: #{options[:gist]}") do |value|
          options[:gist] = value
        end
        
        opt.on("-G","--[no-]github","Search github.com","  Default: #{options[:github]}") do |value|
          options[:github] = value
        end
        
        opt.on("-i","--[no-]pastie","Search pastie.org (Gscraper)","  Default: #{options[:pastie]}") do |value|
          options[:pastie] = value
        end
        
        opt.on("-i","--[no-]pastee","Search pastee.org (Gscraper)","  Default: #{options[:pastie]}") do |value|
          options[:pastee] = value
        end
        
        opt.separator "Report Output:: (Default output to STDOUT)"
        
        opt.on("-H","--html-report","Create an html iframed (report.html) ") do
          options[:report] = true
        end
  
        opt.on("-J", "--json-report", "Create a JSON file (report.json) ") do
          options[:json] = true
        end 


        opt.separator "Options::"
        
        opt.on("-r","--[no-]raw","use 'raw' urls instead if available" ,"  Default: #{options[:raw]}") do |value|
          options[:raw] = value
        end
        
        opt.on("-m","--maxpages=","maximum number of search results pages to iterate through" ,"  Default: #{options[:maxpages]}") do |value|
          options[:maxpages] = value
        end
        
        opt.on("-x", "--tos", "Acknowledge Google INC. 'Terms of Service'") do 
          options[:tos] = true
        end
=begin        
        opt.on("-o","--onion","use tor-network socks mode?") do
          options[:onion] = true
        end
  
        opt.on("-t", "--test", "Run Test suite") do 
          options[:test] = v
        end 
=end  
        opt.on("-V", "--[no-]ssl-verify", "Verify SSL certificates","  Default: #{options[:ssl_verify]}") do |value|
          options[:ssl_verify] = value
        end
        
        opt.on("-v", "--verbose", "Run verbosely") do 
          options[:verbose] = true
        end
  
        opt.on_tail("-h","--help","Display this screen") do
          puts opt_parser
          exit 0
        end
        
  
      end

      #Verify the options
      begin
        raise unless ARGV.size > 0
        opt_parser.parse!
  
      #If options fail display help
      #rescue Exception => e  
      #  puts e.message  
      #  puts e.backtrace.inspect  
      rescue 
        puts opt_parser
        exit
      end
      
      dork = ARGV[0]
      
      if options[:onion]
        session.set_tor
        puts "Fetching Tor Exit IP"
        session.tor_check
        ensure_tor = ask("Are you protected? [NO/yes]")
        exit 1 if ensure_tor != 'yes'
      end
      
      if !(options[:tos])
        puts "You are using Gscraper, a non-compliant Google Search API screen scraping utility.".red
        puts ""
        puts "*** Google Terms of Service: March 1, 2012 "
        puts " [..] This license is for the sole purpose of enabling you to "
        puts " use and enjoy the benefit of the Services as provided by Google,"
        puts " in the manner permitted by these terms. [..] *** "
        puts ""
        ensure_tos = ask("Do you want to continue? [NO/yes]")
        exit 1 if ensure_tos != 'yes'
      end 
    
      if options[:verbose]
        puts "++++++++++++++++++++++++++++++++++++++++++++++".green
        puts "+ Pastie Enum".green
        puts "+ Version #{VERSION}".green
        puts "++++++++++++++++++++++++++++++++++++++++++++++\n".green
      end
      
      @gist = Pastenum::Gist.new(dork)
      @github = Pastenum::Github.new(dork)
      @pastebin = Pastenum::Pastebin.new(dork)
      @pastie = Pastenum::Pastie.new(dork)
      
      
      if options[:gist]
        
        @gist.verbose = options[:verbose]
        @gist.max_pages = options[:maxpages]
        @gist.verify_ssl_mode = OpenSSL::SSL::VERIFY_NONE unless options[:ssl_verify]
        @gist.search
        @gist.summary
        if options[:raw]
          @gist.results.each { |hit| puts "#{@gist.raw_url}#{hit}" } if !options[:report] && !options[:json]
        else  
          @gist.results.each { |hit| puts "#{@gist.vendor}#{hit}" } if !options[:report] && !options[:json]
        end 
      end
      
      if options[:github]
        @github.verbose = options[:verbose]
        @github.max_pages = options[:maxpages]
        @github.verify_ssl_mode = OpenSSL::SSL::VERIFY_NONE unless options[:ssl_verify]
        @github.raw = true if options[:raw]
        @github.search
        @github.summary 
        
        puts @github.results if !options[:report] && !options[:json]
      end
      
      if options[:pastebin]
        @pastebin.verbose = options[:verbose]
        @pastebin.max_pages = options[:maxpages]
        @pastebin.search
        @pastebin.summary
        
        if options[:raw]
          @pastebin.results.each { |hit| puts "#{@pastebin.raw_url}#{hit}" } if !options[:report] && !options[:json]
        else  
          @pastebin.results.each { |hit| puts "http://pastebin.com/#{hit}" } if !options[:report] && !options[:json]
        end 
      end

      if options[:pastie]
        @pastie.verbose = options[:verbose]
        @pastie.max_pages = 2
        @pastie.raw = true if options[:raw]
        @pastie.search
        @pastie.summary
        puts @pastie.results if !options[:report] && !options[:json]
      end
      
      if options[:pastee]
        @pastee.verbose = options[:verbose]
        @pastee.max_pages = 2
        @pastee.search
        @pastee.summary
        puts @pastee.results if !options[:report] && !options[:json]
      end
      
      
      if options[:report]
        Pastenum::Report.new(dork, @pastie.results, @pastee.results, @pastebin.results, @github.results, @gist.results).to_file
      end
      
      if options[:json]
        Pastenum::JSON.new(dork, [@gist, @github, @pastebin, @pastie, @pastee]).to_file
      end

    end

  end
end