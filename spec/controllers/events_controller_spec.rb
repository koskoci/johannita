require 'rails_helper'

RSpec.describe EventsController, :type => :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /events' do
    before do
      create_list(:event, 2)
    end

    it "sends a list of events", :aggregate_failures do
      get '/events', headers: get_headers(current_user)

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_type("events")
      expect(json_response['data']).to all have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
      expect(json_response['data']).to all have_relationship(:participants)
    end
  end

  describe 'GET /events/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the event exists" do
      let(:event) { create(:event, id: 1) }

      before do
        event
      end

      context "when there is no attachment" do
        it "sends a single event", :aggregate_failures do
          get '/events/1', headers: headers

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("events")
          expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
          expect(json_response['data']).to have_relationship(:participants)
        end
      end

      context "when there are participants" do
        let(:other_user) { create(:user) }

        before do
          Participant.create(event: event, user: other_user)
          Participant.create(event: event, user: current_user)
        end

        it "sends a single event with all included participants", :aggregate_failures do
          get '/events/1', headers: headers

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("events")
          expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
          expect(json_response['data']).to have_relationship(:participants)
          expect(json_response['included'].size).to eq 2
          expect(json_response['included'])
            .to include(have_type('participants').and have_attributes(:name, :email))
        end
      end
    end

    context "when the event does not exist" do
      it "returns 404", :aggregate_failures do
        get '/events/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event does not exist"
      end
    end
  end

  describe 'POST /events' do
    subject { post '/events', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "events",
          "attributes": {
            "title": "First event title",
            "content": "First event content"
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

      it "creates a Event in the database" do
        expect { subject }
          .to change(Event, :count).by(+1)
      end

      it "returns the created Event" do
        subject

        expect(json_response['data']).to have_type("events")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['data']['id']).not_to be nil
      end
    end
  end

  describe 'PATCH /events/:id' do
    subject { patch '/events/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "events",
          "attributes": {
            "title": "Updated event title",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:event) { create(:event, id: 1) }
    let(:headers) { post_headers(current_user) }

    before do
      current_user
      event
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new Event in the database" do
      expect { subject }.not_to change(Event, :count)
    end

    it "changes the Event in the database" do
      expect { subject }
        .to change { Event.find(1).title }
        .from("My event").to("Updated event title")
      expect { subject }
        .not_to change { Event.find(1).category }
    end

    it "returns the updated Event" do
      subject

      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
      expect(json_response['data']).to have_type("events")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the event does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/events/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event does not exist"
      end
    end
  end
end