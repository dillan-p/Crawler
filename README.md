# Crawler

This repository contains a domain crawler implemented in Ruby.
It utilises REST client to make HTTP requests, and Nokogiri to parse the DOM.

## Installation

You'll need to use Ruby 2.3.3. This is defined using the `.ruby-version` file.

Before running the program, you'll also need to install the gems on your local machine.
You can do this by running `bundle install`.

## Running the crawler

To run the crawler, type `bundle exec ruby crawler.rb {domain}`, where `{domain}` is
the domain you wish to crawl.
