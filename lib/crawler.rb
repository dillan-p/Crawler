require "set"
require_relative "dom_parse"
require_relative "http_request"
require "uri"
require "json"

class Crawler
  attr_reader :start_url, :stdout

  def initialize(url)
    @start_url = url
    @visited_urls = Set.new
    @stdout = []
  end

  def crawl
    queue = [start_url]
    until queue.empty?
      p url = relative_url(queue.shift)
      next if domain(url) || @visited_urls.include?(url)
      @visited_urls << url
      page = HTTPRequest.new(url).get
      parse = DomParse.new(page)
      links = parse.extract_links
      links.map { |link| queue << link unless @visited_urls.include?(link) }
      assets = parse.extract_assets
      stdout_add(url, assets)
    end
  end

  def stdout_add(url, assets)
    @stdout << {url: url, assets: assets}
  end

  private

  def relative_url(url)
    return url[0] == "/" ? start_url + url : url
  end

  def domain(url)
    begin
      start_host = URI.parse(start_url).host
      link_host = URI.parse(url).host
      return start_host != link_host ? true : false
    rescue
      return true
    end
  end
end

domain = ARGV.first

def crawler_run(domain)
  crawler = Crawler.new(domain)
  crawler.crawl
  puts crawler.stdout.to_json
end

crawler_run(domain)