require "nokogiri"
require "uri"

class DomParse
  attr_reader :seed_url, :body

  def initialize(seed_url, body)
    @seed_url = seed_url
    @body = body
  end

  def extract_links
    html = Nokogiri::HTML(body)
    html.css("a").map do |link|
      absolute_url(link["href"])
    end
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
    assets.uniq
  end

  private

  def absolute_url(link)
    return link.include?("http") ? link : seed_url + link
  end

  def asset_type(selector, asset)
    if selector == "link"
      return asset["href"] if asset["href"].include?(".css")
    else
      return asset["src"]
    end
  end
end
