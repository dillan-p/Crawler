# frozen_string_literal: true

require 'spec_helper'
require 'crawler'

RSpec.describe Crawler do
  let(:base_url) { "http://fakecrawl.com#{path}" }
  subject(:result) { described_class.new(base_url).crawl }

  context 'when there are no assets or links' do
    let(:path) { '' }
    it 'returns only the start url with no assets' do
      is_expected.to eq([{ url: 'http://fakecrawl.com', assets: [] }])
    end
  end

  context 'when there are links' do
    let(:path) { '/links' }
    it 'returns them' do
      is_expected.to eq(
        [
          { url: 'http://fakecrawl.com/links', assets: [] },
          { url: 'http://fakecrawl.com/end', assets: [] }
        ]
      )
    end
  end

  context 'when there are assets' do
    let(:path) { '/assets/1' }
    it 'returns them and matches them with the corresponding url' do
      is_expected.to eq(
        [
          { url: 'http://fakecrawl.com/assets/1', assets: ['theme.css'] },
          { url: 'http://fakecrawl.com/assets/2', assets: ['test.png', 'index.js'] }
        ]
      )
    end
  end

  context 'when a request throws an HTTP error' do
    let(:path) { '/error/200' }
    it 'is expected not to raise and the url is not recorded' do
      is_expected.to eq(
        [
          { url: 'http://fakecrawl.com/error/200', assets: [] },
          { url: 'http://fakecrawl.com/end', assets: [] }
        ]
      )
    end
  end
end
