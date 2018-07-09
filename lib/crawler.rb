require "set"
require_relative "dom_parse"
require_relative "http_request"
require "uri"
require "json"

class Crawler
  attr_reader :start_url, :url_assets

  def initialize(url)
    @start_url = url
    @visited_urls = Set.new
    @url_assets = []
  end

  def crawl
    queue = [start_url]
    until queue.empty?
      p current_url = format_url(queue.shift)
      next if is_different_domain?(current_url) || @visited_urls.include?(current_url)
      @visited_urls << current_url
      page = HTTPRequest.new(current_url).get
      parse = DomParse.new(page)
      links = parse.extract_links
      links.map { |link| queue << link unless @visited_urls.include?(link) }
      assets = parse.extract_assets
      store_url_assets(current_url, assets)
    end
  end

  private

  def store_url_assets(url, assets)
    @url_assets << {url: url, assets: assets}
  end

  def format_url(url)
    escaped_url = URI.escape(url)
    url[0] == "/" ? start_url + escaped_url : escaped_url
  end

  def is_different_domain?(url)
    start_host = URI.parse(start_url).host
    link_host = URI.parse(url).host
    start_host != link_host ? true : false
  end
end

domain = ARGV.first

def crawler_run(domain)
  crawler = Crawler.new(domain)
  crawler.crawl
  puts crawler.url_assets.to_json
end

crawler_run(domain)