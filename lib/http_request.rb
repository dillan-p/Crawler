require 'rest-client'
require 'uri'

class RequestFailure < StandardError
end

module HTTPRequest
  def self.get(url)
    begin
      RestClient.get(url).body
    rescue RestClient::ExceptionWithResponse => e
      raise RequestFailure, e.response
    end
  end
end
