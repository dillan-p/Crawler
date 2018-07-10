require "spec_helper"
require "dom_parser"

RSpec.describe DomParser do
  let(:seed_url) { "http://www.example.org" }

  describe "#extract_links" do
    context "when passed a HTML body" do
      let(:body_links) { "<p><a href='http://www.example.org/foo'>More</a></p>
      <p>Follow <a href='http://www.iana.org/'>official here</a>.</p>" }
      subject(:parser) { described_class.new(body_links) }

      it "returns the links in the body" do
        expect(parser.extract_links).to eq(["http://www.example.org/foo",
          "http://www.iana.org/"])
      end
    end
  end

  describe "#extract_assets" do
    context "when body contains image, javascript file and stylesheet" do
      let(:body_assets) { "<img src='/assets/images/supplementals/web-inspecting/parsing/parse-hello.png' alt='Parsing with Firebug'>
      <script src='myscripts.js'></script><link rel='stylesheet' href='/html/styles.css'>" }
      subject(:parser_assets) { described_class.new(body_assets) }

      it "returns them in an array"do
        expect(parser_assets.extract_assets).to eq([
          "/assets/images/supplementals/web-inspecting/parsing/parse-hello.png",
          "myscripts.js", "/html/styles.css"])
      end
    end
  end
end
