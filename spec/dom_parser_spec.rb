# frozen_string_literal: true

require 'spec_helper'
require 'dom_parser'

RSpec.describe DomParser do
  subject(:parse) { described_class.new(body).parse }

  describe '#parse' do
    context 'when passed a HTML body with just links' do
      let(:body) {
        '<p><a href="http://www.example.org/foo">More</a></p>
        <p>Follow <a href="http://www.iana.org/">official here</a>.</p>'
      }

      it 'returns the links' do
        expect(parse).to eq([
                              [
                                'http://www.example.org/foo',
                                'http://www.iana.org/'
                              ],
                              []
                            ])
      end
    end

    context 'when passed a HTML body with assets' do
      let(:body) {
        '<img src="/assets/images/supplementals/web-inspecting/parsing/parse-hello.png"
        alt="Parsing with Firebug"><script src="myscripts.js"></script>
        <link rel="stylesheet" href="/html/styles.css">'
      }

      it 'returns the assets' do
        expect(parse).to eq([
                              [],
                              [
                                '/assets/images/supplementals/web-inspecting/parsing/parse-hello.png',
                                'myscripts.js',
                                '/html/styles.css'
                              ]
                            ])
      end
    end

    context 'when passed both html and assets' do
      let(:body) {
        '<p><a href="http://www.example.org/foo">More</a></p>
        <p>Follow <a href="http://www.iana.org/">official here</a>.</p>
        <img src="/assets/images/supplementals/web-inspecting/parsing/parse-hello.png"
        alt="Parsing with Firebug"><script src="myscripts.js"></script>
        <link rel="stylesheet" href="/html/styles.css">'
      }

      it 'returns the assets' do
        expect(parse).to eq([
                              [
                                'http://www.example.org/foo',
                                'http://www.iana.org/'
                              ],
                              [
                                '/assets/images/supplementals/web-inspecting/parsing/parse-hello.png',
                                'myscripts.js',
                                '/html/styles.css'
                              ]
                            ])
      end
    end
  end
end
