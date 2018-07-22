# frozen_string_literal: true

require 'nokogiri'

# Extracts links and assets in the DOM
class DomParser
  def initialize(body)
    @document = Nokogiri::HTML(body)
  end

  def parse
    [extract_links, extract_assets]
  end

  private

  def extract_links
    @document.css('a').map do |link|
      link['href']
    end.compact
  end

  def extract_assets
    @document.css('img', 'script', 'link').map do |element|
      if element['rel'] == 'stylesheet'
        element['href']
      else
        element['src']
      end
    end.compact.uniq
  end
end
