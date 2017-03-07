require "spec_helper"
require "http_request"

RSpec.describe HTTPRequest do
  let(:url) { "http://www.example.org" }
  subject(:http) { described_class.new(url) }

  describe "#get" do
    context "when a url is passed to the function" do
      it "returns the DOM body" do
        stub_request(:get, "http://www.example.org").
          to_return(body: "<p>Hello world!</p>")

        expect(http.get).to eq("<p>Hello world!</p>")
      end
    end
  end
end
