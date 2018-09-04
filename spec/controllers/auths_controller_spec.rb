require 'rails_helper'

RSpec.describe AuthsController, :type => :request do
  let(:token) { Authentication::Jwt.encode(user_id: 1, exp: 24.years.from_now.to_i) }

  context "when the user exists" do
    before do
      create(:user, id: 1, email: "foo@bar.com", password: "abc")
      allow(Authentication::Jwt).to receive(:encode).and_return(token)
    end

    it "authenticates the user", :aggregate_failures do
      post '/auth?user=foo@bar.com&password=abc'

      expect(response.status).to eq 200
      expect(json_response['token']).to eq(token)
    end

    context "when the password is incorrect" do
      it "rejects the user", :aggregate_failures do
        post '/auth?user=foo_1@bar.com&password=123'

        expect(response.status).to eq 401
        expect(json_response['error']).to eq({ "base" => ["User credentials invalid!"] })
      end
    end
  end

  context "when the user does not exist" do
    it "rejects the user", :aggregate_failures do
      post '/auth?user=fee@baz.com&password=abc'

      expect(response.status).to eq 401
      expect(json_response['error']).to eq({ "base" => ["User credentials invalid!"] })
    end
  end
end
