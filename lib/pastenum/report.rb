module Pastenum
  class Report
  
    def initialize(dork,addresses_pastie,addresses_pastebin,addresses_github,addresses_gist)
      @dork = dork
      @addresses_pastie = addresses_pastie 
      @addresses_pastebin = addresses_pastebin
      @addresses_github = addresses_github
      @addresses_gist = addresses_gist
    end
      
    def to_file
      puts "[*] Creating HTML Report".green
      print "[*] Status: ".green
      file = File.open('report.html', 'w') 
    
      # Header
    
      file.write("<html><head><title>Pastesearch Results for #{@dork}</title><link rel=\"stylesheet\" type=\"text/css\" href=\"lib/css/main.css\" media=\"screen\" /></head>\n")
    
      file.write("<body><div id=\"container\"><div id=\"logo\"><img src=\"lib/img/logo.gif\" width=\"114\" height=\"36\" /></div>\n")
      file.write("<div id=\"menu\">Pastesearch: This can take some time to render</div>\n")
      file.write("<div id=\"content\">")
        
      # Pastebin.com
      unless @addresses_pastebin.empty?         
        file.write("<br /><h2>Site: Pastebin - Found: #{@addresses_pastebin.count} Items</h2>\n")  
        @addresses_pastebin.each do |links|
          file.write("<p><iframe src=\"http://pastebin.com/embed_iframe.php?i=#{links}\" style=\"border:none;width:100%;height:300px\"></iframe><p>link: <a href=\"http://pastebin.com/#{links}\" target=\"_blank\">http://pastebin.com/#{links}</a>\n")
          print ".".green
        end
        file.write("<hr><hr>")
      end
    
      #gist.github.com
      unless @addresses_gist.empty?
        file.write("<br /><h2>Site: Github Gist - Found: #{@addresses_gist.count} Items</h2>\n")
        @addresses_gist.each do |links|
          file.write("<p><script src=\"https://gist.github.com#{links}.js\"></script><p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a>\n")
          print ".".green
        end
      end
      
      #Pastie.org
      unless @addresses_pastie.empty?
        file.write("<h2>Search Term: \"#{@dork}\" <br /> Site: Pastie - Found: #{@addresses_pastie.count} Items</h2>\n")
        @addresses_pastie.each do |links|
          file.write("<p><iframe src=#{links}/text style=\"width: 100%; height: 300px; background-color: white\"></iframe><p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a>\n")
          print ".".green
        end
        file.write("<hr><hr>")
      end
      
      #Github.com
      # Github passes x-frame-options	deny so you can not iframe this result.
      unless @addresses_github.empty?
        file.write("<br /><h2>Site: Github - Found: #{@addresses_github.count} Items</h2>\n")
        @addresses_github.each do |links|
          file.write("<p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a></p>\n")
          print ".".green
        end
      end    
      # Footer
    
      file.write("</div>\n")
      file.write("<div id=\"footer\">&copy; Corelan Team | Written by Nullthreat\n")
      file.write("<center><img src=\"lib/img/corelanlogo_small.jpg\"></center></div>\n")
      file.write("</div></body></html>\n")
      file.close
    
      puts "\n[*] HTML Report Created".green
    end
  end
end
