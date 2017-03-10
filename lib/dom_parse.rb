require "nokogiri"
require "uri"

class DomParse
  attr_reader :seed_url, :body

  def initialize(body)
    @body = body
  end

  def extract_links
    html = Nokogiri::HTML(body)
    html.css("a").map do |link|
      link["href"]
    end.reject { |link| link.nil? }
  end

  def extract_assets
    html = Nokogiri::HTML(body)
    selectors = ["img", "script", "link"]
    assets = []
    selectors.each do |selector|
      html.css(selector).map do |asset|
        assets << asset_type(selector, asset)
      end
    end
    assets.uniq.reject { |asset| asset.nil? }
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
