require 'rails_helper'

RSpec.describe EventCategoriesController, :type => :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /event_categories' do
    before do
      create_list(:event_category, 2)
    end

    it "sends a list of event_categories", :aggregate_failures do
      get '/event_categories', headers: get_headers(current_user)

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_attributes(:category, :last_date, :created_at, :updated_at)
      expect(json_response['data']).to all have_type("event_categories")
    end
  end

  describe 'GET /event_categories/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the event_category exists" do
      before do
        create(:event_category, id: 1)
      end

      it "sends a single event_category", :aggregate_failures do
        get '/event_categories/1', headers: headers

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("event_categories")
        expect(json_response['data']).to have_attributes(:category, :last_date, :created_at, :updated_at)
      end
    end

    context "when the event_category does not exist" do
      it "returns 404", :aggregate_failures do
        get '/event_categories/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event category does not exist"
      end
    end
  end

  describe 'POST /event_categories' do
    subject { post '/event_categories', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "event_categories",
          "attributes": {
            "category": "Elsosegely-tanfolyam",
          }
        }
      }
    end
    let(:headers) { post_headers(current_user) }

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "returns 201" do
        subject

        expect(response.status).to eq 201
      end

      it "creates a EventCategory in the database" do
        expect { subject }
          .to change(EventCategory, :count).by(+1)
      end

      it "returns the created EventCategory" do
        subject

        expect(json_response['data']).to have_attributes(:category, :last_date, :created_at, :updated_at)
        expect(json_response['data']).to have_type("event_categories")
        expect(json_response['data']['id']).not_to be nil
      end
    end
  end

  describe 'PATCH /event_categories/:id' do
    subject { patch '/event_categories/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "event_categories",
          "attributes": {
            "category": "Zsakpakolo-tanfolyam",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:event_category) { create(:event_category, id: 1) }
    let(:headers) { post_headers(current_user) }

    before do
      current_user
      event_category
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new EventCategory in the database" do
      expect { subject }.not_to change(EventCategory, :count)
    end

    it "changes the EventCategory in the database" do
      expect { subject }
        .to change { EventCategory.find(1).category }
        .from("Elsosegely-tanfolyam").to("Zsakpakolo-tanfolyam")
      expect { subject }
        .not_to change { EventCategory.find(1).last_date }
    end

    it "returns the updated EventCategory" do
      subject

      expect(json_response['data']).to have_attributes(:category, :last_date, :created_at, :updated_at)
      expect(json_response['data']).to have_type("event_categories")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the event_category does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/event_categories/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event category does not exist"
      end
    end
  end

  describe 'DELETE /event_categories/:id' do
    subject { delete '/event_categories/1', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:event_category) { create(:event_category, id: 1) }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      event_category
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it "deletes the EventCategory from the database" do
      expect { subject }.to change(EventCategory, :count).by(-1)
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the event_category does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/event_categories/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event category does not exist"
      end
    end
  end
end
