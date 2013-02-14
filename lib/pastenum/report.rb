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
    
      file.write("<html><head><title>Pastenum - #{@dork}</title>\n")
      file.write("<style>\n")
      file.write("body{background-color:#931b1c;color:#fff;font-family:Tahoma,Arial,Helvetica,sans-serif;font-size:.75em}#container{background-color:#000;margin:0 auto;padding:10px;width:90%}#logo{float:left;width:124px}#menu{background-color:#333;float:right;padding:10px;text-align:right;width:70%;height:17px}#footer{background-color:#333;clear:both;font-size:.80em;padding:2px;text-align:center;width:100%}#content{clear:both;padding-top:5px;padding-bottom:10px}img{border:0}#menu li{display:inline;margin-left:10px}#menu ul{margin:0;padding:0;list-style-type:none}#portfolio li{display:inline;margin-right:10px}#portfolio ul{margin:0;padding:0;list-style-type:none;padding-bottom:10px}a:hover{color:#ccc;text-decoration:none}a{color:#888;text-decoration:none}a.on{color:#ccc;text-decoration:none}h1{font-family:Georgia,"Times New Roman",Times,serif;font-weight:normal;font-size:1.3em}.center{text-align:center}input{background-color:#000;font-family:Tahoma,Arial,Helvetica,sans-serif;font-size:1em;color:#fff;border-color:#fff;border-width:thin}textarea{background-color:#000;font-family:Tahoma,Arial,Helvetica,sans-serif;font-size:1em;color:#fff;border-color:#fff;border-width:thin}\n")
      
      file.write("</style>\n")
      file.write("</head>\n")
    
      file.write("<body><div id=\"container\"><div id=\"logo\">")
      file.write("<img alt=\"Corelan Logo\" src=\"data:image/jpeg;base64,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\" />\n")
      
      
      file.write("</div>\n")
      file.write("<div id=\"menu\">Pastenum - Search Results for: '#{@dork}'</div>\n")
      file.write("<div id=\"content\">")
        
      #gist.github.com
      unless @addresses_gist.empty?
        file.write("<br /><h2>Site: Github Gist - Found: #{@addresses_gist.count} Items</h2>\n")
        @addresses_gist.each do |links|
          file.write("<p><script src=\"https://gist.github.com#{links}.js\"></script><p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a>\n")
          print ".".green
        end
      end
      
      #Github.com
      unless @addresses_github.empty?
        file.write("<br /><h2>Site: Github - Found: #{@addresses_github.count} Items</h2>\n"
        file.write("NOTE: Github passes 'x-frame-options deny' so iframes are useless.\n")
        @addresses_github.each do |links|
          file.write("<p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a></p>\n")
          print ".".green
        end
      end 

      # Pastebin.com
      unless @addresses_pastebin.empty?         
        file.write("<br /><h2>Site: Pastebin - Found: #{@addresses_pastebin.count} Items</h2>\n")  
        @addresses_pastebin.each do |links|
          file.write("<p><iframe src=\"http://pastebin.com/embed_iframe.php?i=#{links}\" style=\"border:none;width:100%;height:300px\"></iframe><p>link: <a href=\"http://pastebin.com/#{links}\" target=\"_blank\">http://pastebin.com/#{links}</a>\n")
          print ".".green
        end
        file.write("<hr><hr>")
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

      # Footer

      file.write("</div>\n")
      file.write("<div id=\"footer\">&copy; Corelan Team | Written by Nullthreat\n")
      file.write("</div></body></html>\n")
      file.close

      puts "\n[*] HTML Report Created".green
    end
  end
end
