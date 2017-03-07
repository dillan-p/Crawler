require "spec_helper"
require "dom_parse"

RSpec.describe DomParse do
  let(:seed_url) { "http://www.example.org" }

  describe "#extract_links" do
    context "when passed a HTML body" do
      let(:body_links) { "<p><a href='http://www.example.org/foo'>More</a></p>
      <p>Follow <a href='http://www.iana.org/'>official here</a>.</p>" }
      subject(:parser) { described_class.new(seed_url, body_links) }

      it "returns the links in the body" do
        expect(parser.extract_links).to eq(["http://www.example.org/foo",
          "http://www.iana.org/"])
      end
    end

    context "when body contains absolute urls" do
      let(:body_absolute_urls) { "<p><a href='/foo'>More</a></p>
      <p>Follow <a href='/bar'>official here</a>.</p>" }
      subject(:parser_absolute_urls) { described_class.new(seed_url, body_absolute_urls) }

      it "returns the full url" do
        expect(parser_absolute_urls.extract_links).to eq([
          "http://www.example.org/foo", "http://www.example.org/bar"])
      end
    end

    # context "when body contains subdomains" do
    #   let(:body_subdomains) { "<p><a href='http://mail.example.org'>More</a></p>
    #   <p>Follow <a href='http://www.iana.org/'>official here</a>.</p>" }
    #   subject(:parser_subdomains) { described_class.new(seed_url, body_subdomains) }
    #
    #   it "rejects them" do
    #     expect(parser_subdomains.extract_links).to eq(["http://www.iana.org/"])
    #   end
    # end
  end

  describe "#extract_assets" do
    context "when body contains image, javascript file and stylesheet" do
      let(:body_assets) { "<img src='/assets/images/supplementals/web-inspecting/parsing/parse-hello.png' alt='Parsing with Firebug'>
      <script src='myscripts.js'></script><link rel='stylesheet' href='/html/styles.css'>" }
      subject(:parser_assets) { described_class.new(seed_url, body_assets) }

      it "returns them in an array"do
        expect(parser_assets.extract_assets).to eq([
          "/assets/images/supplementals/web-inspecting/parsing/parse-hello.png",
          "myscripts.js", "/html/styles.css"])
      end
    end
  end
end
