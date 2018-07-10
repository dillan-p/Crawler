require 'spec_helper'
require 'http_request'

RSpec.describe HTTPRequest do
  describe '#get' do
    let(:url) { 'http://www.example.org' }
    subject(:get) { HTTPRequest.get(url) }
    
    context 'when a successful request is made' do
      it 'returns the DOM body' do
        stub_request(:get, 'http://www.example.org').
          to_return(body: '<p>Hello world!</p>')

        expect(get).to eq('<p>Hello world!</p>')
      end
    end

    context 'when the request fails' do
      it 'raises a custom exception with the response' do
        stub_request(:get, 'http://www.example.org').
          to_raise(RequestFailure.new('<RestClient::Response 404 "<!doctype h...">'))

        expect { get }.to raise_error(RequestFailure, '<RestClient::Response 404 "<!doctype h...">')
      end
    end
  end
end
