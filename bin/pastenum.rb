

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
