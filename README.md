#Pastenum

Pastenum is a gem rewrite of nullthreat's original pastenum2 google scrapper. 

Install:
------
* Install Ruby 1.9.* 

* Install RubyGems 

* gem install pastenum

Troubleshooting: 
======

** Note: nokogiri in the gemfile requires native libxslt and libxml2 to be installed

Usage:
------
`$> pastenum.rb`

When prompted enter a search term.
Once the application is complete it will generate "report.html"

** Note: If more then 100 results are found, it can take some time to load the "report.html" file.


Notes on Future Versions:
------

Gist / Github
------

Use the appropriate API for github

http://developer.github.com/v3/repos/

Gscaper -> Google Custom Search API:
------

Important: The Google Custom Search API requires the use of an API key, which you can get from the Google APIs console. The API provides 100 search queries per day for free. If you need more, you may sign up for billing in the console.

https://developers.google.com/custom-search/v1/overview

Original Pastenum Credits: 
------

Pastenum - A Corelan Team Production
Written by: Nullthreat

www.corelan.be
www.nullthreat.net
irc.freenode.net #corelan

