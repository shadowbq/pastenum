module Pastenum
  class JSON
  
    def initialize(dork, pastie, pastebin, github, gist)
      file = File.open('report.json', 'w') 
      data =  [{:search => dork}, {gist.vendor => gist.results}, {github.vendor => github.results},  {pastebin.vendor => pastebin.results}, {pastie.vendor => pastie.results} ].to_json
      file.write(data)
      file.close
      
      return data
    end
      
  end
end