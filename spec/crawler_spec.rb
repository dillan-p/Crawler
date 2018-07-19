# frozen_string_literal: true

require 'spec_helper'
require 'crawler'

RSpec.describe Crawler do
  let(:url) { "http://fakecrawl.com#{path}" }
  subject(:result) { described_class.new(url).crawl }

  context 'when start url has no assets or links' do
    let(:path) { '' }
    it 'returns only the start url with no assets' do
      is_expected.to eq([{ url: 'http://fakecrawl.com', assets: [] }])
    end
  end
end
