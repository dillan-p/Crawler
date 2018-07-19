# frozen_string_literal: true

require 'rest-client'
require 'uri'

class CrawlerRequestError < StandardError; end

# Retrieves the DOM as a string for a given url
module HTTPRequest
  def self.get(url)
    RestClient.get(url).body
  rescue RestClient::ExceptionWithResponse => e
    raise CrawlerRequestError, e.response
  end
end
