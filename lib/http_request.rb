require "rest-client"

class HTTPRequest
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def get
    request = RestClient.get(url)
    request.body
  end
end
