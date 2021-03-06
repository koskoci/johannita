require "rails_helper"

RSpec.describe Authentication::Jwt do
  let(:payload) { { "one" => "two" } }
  let(:token) { "eyJhbGciOiJIUzI1NiJ9.eyJvbmUiOiJ0d28ifQ.6F0mOFnN4qCYsu_Nvk1bSLSonA2yBx18ZIv43TF1Szg" }

  describe '.encode' do
    it { expect(described_class.encode(payload)).to eq(token) }
  end

  describe '.decode' do
    it { expect(described_class.decode(token)).to eq(payload) }
  end
end
