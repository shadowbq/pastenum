#Internal search implementation for pastee.org (Gscraper)
# Standard link
# https://pastee.org/9gxe6
# Raw link
# No Raw link available

# url -> "https://pastee.org/9gxe6"

module Pastenum
  class Pastee < Target
    
    def initialize(dork)
      @dork = URI.escape(dork)
      @vendor = "https://pastee.org"

      super
    end

    def search
      puts "[*] Searching Pastee.org (Limit: First #{@max_pages} Pages)".green if @verbose
      q = GScraper::Search.query(:query => @dork + " inurl:pastes -inurl:page", :site => 'pastie.org')
      print "[*] Parsing pages:".green if @verbose
      begin
        for i in 1..@max_pages do
          print ".".green if @verbose
          page = q.page(i)
          page.each do |result|
            if result.url.to_s.match(/[0-9a-ZA-Z]+$/)
              code = result.url.to_s.split("/").last
              # code -> "9gxe6"
                @results << "http://pastee.org/#{code}"
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
