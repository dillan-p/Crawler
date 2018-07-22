# Crawler

[![CircleCI](https://circleci.com/gh/dillan-p/Crawler.svg?style=svg&circle-token=182dc8f8fadb13013733f35d3c527c0658945420)](https://circleci.com/gh/dillan-p/Crawler)

This repository contains a web crawler implemented in Ruby. The crawler visits every page under a given domain
and outputs in JSON the URL and its associated static assets.

It utilises [REST Client](https://github.com/rest-client/rest-client) to make HTTP requests and [Nokogiri](https://github.com/sparklemotion/nokogiri) to parse the DOM.

## Installation

You'll need to use Ruby 2.3.3. This is defined in the `.ruby-version` file for those using [rbenv](https://github.com/rbenv/rbenv).

Before running the program, you'll also need to install the gems on your local machine with [bundler](https://github.com/bundler/bundler). Just run `bundle install` and you're ready to begin!

## Running the crawler

```
bundle exec ruby lib/runner.rb "{domain}"
``` 
where `{domain}` is
the domain you wish to crawl.
