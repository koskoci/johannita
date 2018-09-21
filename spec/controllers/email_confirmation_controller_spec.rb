require 'rails_helper'

RSpec.describe EmailConfirmationController, type: :request do
  describe 'PATCH /email_confirmation/:conf_token' do
    let(:auth_token) { "authentication_token" }
    let(:conf_token) { "abc_123" }
    let(:headers) do
      {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      }
    end

    before do
      allow(Authentication::Jwt).to receive(:encode).and_return(auth_token)
      create :user, confirm_token: conf_token
    end

    context "when the conf token does not belong to a user" do
      it "returns 418 and an error" do
        patch "/email_confirmation/foo", headers: headers

        expect(response.status).to eq 418
        expect(json_response['error']).to eq "This email has already been confirmed. Please log in"
      end
    end

    it "returns an authentication token" do
      patch "/email_confirmation/abc_123", headers: headers

      expect(response.status).to eq 200
      expect(json_response['token']).to eq(auth_token)
    end
  end
end
