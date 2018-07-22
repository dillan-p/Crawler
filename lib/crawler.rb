# frozen_string_literal: true

require 'set'
require_relative 'dom_parser'
require_relative 'http_request'
require 'uri'

# Runs the crawler and stores the urls and associated assets
class Crawler
  def initialize(url)
    @start_url = url
    @visited_urls = Set.new
    @url_assets = []
  end

  def crawl(queue = [@start_url])
    until queue.empty?
      current_url = format_url(queue.shift)
      next if visited_or_different_domain?(current_url)
      begin
        process_url(current_url).each { |link| queue << link }
      rescue CrawlerRequestError
        next
      end
    end
    @url_assets
  end

  private

  def process_url(url)
    @visited_urls << url
    links, assets = request_and_parse(url)
    store_url_assets(url, assets)
    links
  end

  def request_and_parse(url)
    page = HTTPRequest.get(url)
    DomParser.new(page).parse
  end

  def store_url_assets(url, assets)
    @url_assets << { url: url, assets: assets }
  end

  def different_domain?(url)
    start_host = URI.parse(@start_url).host
    link_host = URI.parse(url).host
    start_host != link_host
  end

  def format_url(url)
    escaped_url = URI.escape(url)
    url[0] == '/' ? @start_url + escaped_url : escaped_url
  end

  def visited_or_different_domain?(url)
    @visited_urls.include?(url) || different_domain?(url)
  end
end
