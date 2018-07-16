# frozen_string_literal: true
require "json"

require_relative "crawler"

class Runner
  def run
    domain = ARGV.first
    crawler = Crawler.new(domain)
    crawler.crawl
    puts crawler.url_assets.to_json
  end
end
