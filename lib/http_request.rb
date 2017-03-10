require "rest-client"

class HTTPRequest
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def get
    begin
      request = RestClient.get(url)
      request.body
    rescue
      ""
    end
  end
end
