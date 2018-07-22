# frozen_string_literal: true

require 'json'
require_relative 'crawler'

# Test crawler
class Runner
  def self.run
    domain = ARGV.first
    crawler = Crawler.new(domain)
    urls = crawler.crawl
    puts urls.to_json
  end
end

Runner.run
