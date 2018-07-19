# frozen_string_literal: true

require 'sinatra/base'

class FakeServer < Sinatra::Base
  get '/' do
    status 200
    body ''
  end
end
