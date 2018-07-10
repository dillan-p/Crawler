require "nokogiri"
require "uri"

class DomParser
  attr_reader :seed_url, :body

  def initialize(body)
    @body = body
    @parsed_body = Nokogiri::HTML(body)
  end

  def parse
    [extract_links, extract_assets]
  end

  def extract_links
    @parsed_body.css("a").map do |link|
      link["href"]
    end.reject do |link|
      link.nil?
    end
  end

  def extract_assets
    selectors = ["img", "script", "link"]

    assets = selectors.flat_map do |selector|
      @parsed_body.css(selector).flat_map do |asset|
        asset_type(selector, asset)
      end
    end.uniq.reject { |asset| asset.nil? }
  end

  private

  def asset_type(selector, asset)
    if selector == "link"
      return asset["href"] if asset["rel"] == "stylesheet"
    else
      return asset["src"]
    end
  end
end
