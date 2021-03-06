#Pastenum
[![Gem Version](https://badge.fury.io/rb/pastenum.png)](http://badge.fury.io/rb/pastenum)

Pastenum is a text dump enumeration tool. It is designed to help find and enumerate datadumps, and doxs posted on public sites. 

It currently searches sites github.com, gist.github.com, pastebin.com, pastee.org, and pastie.org.

Pastenum is a gem rewrite of nullthreat's original [pastenum2](http://redmine.corelan.be/projects/corelan-pastenum) released in 2011. 

## Code Status

[![Code Climate](https://codeclimate.com/github/shadowbq/pastenum.png)](https://codeclimate.com/github/shadowbq/pastenum)
[![Build Status](https://travis-ci.org/shadowbq/pastenum.png)](https://travis-ci.org/shadowbq/pastenum)
[![Coverage Status](https://coveralls.io/repos/shadowbq/pastenum/badge.png?branch=master)](https://coveralls.io/r/shadowbq/pastenum)

[![Dependency Status](https://gemnasium.com/shadowbq/pastenum.png)](https://gemnasium.com/shadowbq/pastenum)


## Install:

* Install Ruby 1.9.* 

* Install RubyGems 

* gem install pastenum

### Troubleshooting: 

** Note: nokogiri in the gemfile requires native libxslt and libxml2 to be installed

## Usage:

```shell
(~)$ pastenum -h
Usage: pastenum [OPTIONS] "search string"

Sources::
        --[no-]pastebin
                                     Search Pastebin.com (Gscraper)
                                       Default: true
        --[no-]gist
                                     Search Gist.github.com
                                       Default: true
        --[no-]github
                                     Search github.com
                                       Default: true
        --[no-]pastie
                                     Search pastie.org (Gscraper)
                                       Default: true
        --[no-]pastee
                                     Search pastee.org (Gscraper)
                                       Default: true
Report Output:: (Default output to STDOUT)
    -H, --html-report                Create an html iframed (report.html) 
    -J, --json-report                Create a JSON file (report.json) 
Options::
    -r, --[no-]raw                   use 'raw' urls instead if available
                                       Default: false
    -m, --maxpages=                  maximum number of search results pages to iterate through
                                       Default: 2
    -x, --tos                        Acknowledge Google INC. 'Terms of Service'
    -V, --[no-]ssl-verify            Verify SSL certificates
                                       Default: true
    -v, --verbose                    Run verbosely
    -h, --help                       Display this screen
```

** Note: If generating a report iframe, it can take some time to load the "report.html" file.**

### Example Search

Gist and Github code search for 'shadowbq' skipping ssl cert verfication

```shell
(~)$  pastenum -x --no-pastebin --no-pastie --no-pastee --no-ssl-verify "shadowbq"
https://gist.github.com/shadowbq/325430
https://gist.github.com/shadowbq/4556950
https://gist.github.com/shadowbq/2718948
https://github.com/shadowbq/matrix.dot.files/blob/8241fc219a3b4601c6c4b1a487441cf31e90916b/docs/README.vim-colors
https://github.com/shadowbq/easy-bin/blob/6237442a25777e17a869b5131f0f4f38ca62def1/easy-bin.gemspec
https://github.com/shadowbq/pastenum/blob/f1d955652a9fd2f7928d7ae84093aea4fc105f85/pastenum.gemspec
https://github.com/shadowbq/matrix.dot.files/blob/8241fc219a3b4601c6c4b1a487441cf31e90916b/home/.matrix/vim/.gitmodules
https://github.com/shadowbq/matrix.dot.files/blob/4d1519387fb7bfc1e1134c179fe372f232e30cba/home/.gitconfig
https://github.com/shadowbq/pastenum/blob/79f620a98f5d6fbb49c805e25b4206fa70429929/README.md
https://github.com/fabrizioc1/WiFu/blob/d37853fd538319317bb4e4f5d16b3255501b76d1/Gemfile
https://github.com/shadowbq/matrix.dot.files/blob/8241fc219a3b4601c6c4b1a487441cf31e90916b/home/.ssh/config
https://github.com/shadowbq/snorby_suite/blob/a5bfc872c6bc8c2691adf3041fa821dadbec233b/snorby_suite.gemspec
https://github.com/shadowbq/rothparty/blob/22a5e8847592cdc158439faef925ca2a07bb0e4d/rothparty.gemspec

```


## Original Pastenum Credits: 

Pastenum - A Corelan Team Production
Written by: Nullthreat

### Website(s)

http://redmine.corelan.be/projects/corelan-pastenum

http://www.corelan.be

http://www.nullthreat.net

### IRC

irc.freenode.net #corelan

