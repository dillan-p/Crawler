# frozen_string_literal: true

require 'nokogiri'

# Extracts links and assets in the DOM
class DomParser
  def initialize(body)
    @document = Nokogiri::HTML(body)
  end

  def parse
    return extract_links, extract_assets
  end

  private

  def extract_links
    @document.css('a').map { |link| link['href'] }
  end

  def extract_assets
    @document.css('img', 'script', 'link').reduce([]) do |assets, element|
      asset = if element['rel'] == 'stylesheet'
                element['href']
              else
                element['src']
              end

      asset.nil? ? assets : assets << asset
    end
  end
end
