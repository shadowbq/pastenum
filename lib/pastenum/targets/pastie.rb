#Internal search implementation for pastie.org (deprecated, migrate to Gscraper)
# Standard link
# http://pastie.org/pastes/6208073
# Raw link
# http://pastie.org/pastes/6208073/text

# url -> "http://pastie.org/pastes/6700343"

module Pastenum
  class Pastie < Target
    
    def initialize(dork)
      @dork = URI.escape(dork)
      @vendor = "http://pastie.org"

      super
    end

    def search
      puts "[*] Searching Pastebin.com (Limit: First #{@max_pages} Pages)".green if @verbose
      q = GScraper::Search.query(:query => @dork + " inurl:pastes -inurl:page", :site => 'pastie.org')
      print "[*] Parsing pages:".green if @verbose
      begin
        for i in 1..@max_pages do
          print ".".green if @verbose
          page = q.page(i)
          page.each do |result|
            if result.url.to_s.match(/pastes\/[0-9]+$/)
              code = result.url.to_s.split("/").last
              # code -> "6700343"
              if @raw 
                @results << "http://pastie.org/pastes/#{code}/text"
              else
                @results << "http://pastie.org/pastes/#{code}"
              end
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
