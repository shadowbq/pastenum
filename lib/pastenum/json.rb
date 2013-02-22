module Pastenum
  class JSON
  
    def initialize(dork, sites)
      @data =  [{:search => dork}]
      sites.each do |site|
        @data << {site.vendor => site.results}
      end 
    end  
      
    def to_s
      return @data
    end
    
    def to_file  
      file = File.open('report.json', 'w') 
      file.write(data.to_json)
      file.close
      
      return @data
    end
      
  end
end