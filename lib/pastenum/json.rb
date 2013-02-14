module Pastenum
  class JSON
  
    def initialize(dork, pastie, pastebin, github, gist)
      return [{:search => dork}, {gist.vendor => gist.results}, {github.vendor => github.results},  {pastebin.vendor => pastebin.results}, {pastie.vendor => pastie.results} ].to_json
    end
      
  end
end