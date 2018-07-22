# frozen_string_literal: true

require 'sinatra/base'

class FakeServer < Sinatra::Base
  def initialize
    super()
    @base_url = 'http://fakecrawl.com'
  end

  get '/' do
    status 200
    body ''
  end

  get '/links' do
    status 200
    body "<a href='#{@base_url}/end'>end</a>"
  end

  get '/assets/:id' do |id|
    message = asset_message(id)

    status 200
    body message
  end

  get '/error/:http_code' do |status|
    code, message = error_response(status)

    status code
    body message
  end

  get '/visited' do
    status 200
    body "<a href='#{@base_url}/visited'>visited</a>"
  end

  get '/diff' do
    status 200
    body '<a href="http://differentcrawl.com">diff</a>'
  end

  get '/path' do
    status 200
    body '<a href="/end">end</a>'
  end

  get '/path/end' do
    status 200
    body '<a href="/end">end</a>'
  end

  get '/pathend' do
    status
  end

  get '/end' do
    status 200
    body ''
  end

  private

  def asset_message(id)
    if id == '1'
      "<a href='#{@base_url}/assets/2'>assets/2</a>
      <link rel='stylesheet' type='text/css' href='theme.css'>"
    else
      '<img src="test.png"><script src="index.js"></script>'
    end
  end

  def error_response(status)
    if status == '200'
      code = 200
      message = "<a href='#{@base_url}/error/404'>error</a>
      <a href='#{@base_url}/end'>end</a>"
    else
      code = 404
      message = ''
    end
    [code, message]
  end
end
