# frozen_string_literal: true

require 'set'
require_relative 'dom_parser'
require_relative 'http_request'
require 'uri'

class Crawler

  def initialize(url)
    @start_url = url
    @visited_urls = Set.new
    @url_assets = []
  end

  def crawl
    queue = [@start_url]
    until queue.empty?
      p current_url = format_url(queue.shift)
      next if is_different_domain?(current_url) || @visited_urls.include?(current_url)
      @visited_urls << current_url
      page = HTTPRequest.get(current_url)
      links, assets = DomParser.new(page).parse
      links.map { |link| queue << link unless @visited_urls.include?(link) }
      store_url_assets(current_url, assets)
    end

    @url_assets
  end

  private

  def store_url_assets(url, assets)
    @url_assets << { url: url, assets: assets }
  end

  def format_url(url)
    escaped_url = URI.escape(url)
    url[0] == '/' ? @start_url + escaped_url : escaped_url
  end

  def is_different_domain?(url)
    start_host = URI.parse(@start_url).host
    link_host = URI.parse(url).host
    start_host != link_host
  end
end
