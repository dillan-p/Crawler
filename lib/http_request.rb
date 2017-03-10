require "rest-client"
require "uri"

class HTTPRequest
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def get
    begin
      safe_url = URI.parse(URI.encode(url.strip)).to_s
      request = RestClient.get(safe_url)
      request.body
    rescue
      ""
    end
  end
end
