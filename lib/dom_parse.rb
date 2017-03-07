require "nokogiri"

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

  private

  def absolute_url(link)
    return link.include?("http") ? link : seed_url + link
  end
end
