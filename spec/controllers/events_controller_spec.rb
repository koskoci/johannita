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

  describe 'POST /events/:id/apply' do
    subject { post '/events/1/apply', headers: headers }

    let(:headers) { post_headers(current_user) }
    let(:event) { create(:event, id: 1) }

    before do
      current_user
      event
    end

    it "returns 200 plus the event with participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("events")
      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included'].size).to eq 1
      expect(json_response['included'])
        .to include(have_type('participants').and have_attributes(:name, :email))
    end

    it "creates an Participant in the database" do
      expect { subject }
        .to change(Participant, :count).by(+1)
    end

    context "when the same participant already exists" do
      before { Participant.create(event: event, user: current_user) }

      it "returns 200 plus the event with participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("events")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included'].size).to eq 1
        expect(json_response['included'])
          .to include(have_type('participants').and have_attributes(:name, :email))
      end
    end

    context "when the event does not exist" do
      it "returns 404", :aggregate_failures do
        post '/events/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event does not exist"
      end
    end
  end

  describe 'PATCH /events/:id/confirm' do
    subject { patch '/events/1/confirm', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:event) { create(:event, id: 1) }
    let(:mailer) { instance_double(EventConfirmedMailer, call: OpenStruct.new(deliver_now: true)) }

    before do
      Participant.create(event: event, user: current_user)
    end

    it "returns 200 plus the event without participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("events")
      expect(json_response['data']).to have_attribute(:status).with_value("confirmed")
      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included']).to be nil
    end

    it "changes the status of the event in the database" do
      expect { subject }
        .to change { Event.find(1).status }
          .from("posted").to("confirmed")
    end

    it "uses the correct mailer" do
      allow(EventConfirmedMailer)
        .to receive(:with).with(user: current_user, event: event)
        .and_return(mailer)

      expect(mailer).to receive(:call).once

      subject
    end

    context "when the status is already confirmed" do
      let(:event) { create(:event, id: 1, status: "confirmed") }

      it "returns 200 plus the event without participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("events")
        expect(json_response['data']).to have_attribute(:status).with_value("confirmed")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included']).to be nil
      end

      it "does not change the status of the event in the database" do
        expect { subject }
          .not_to change { Event.find(1).status }
      end
    end

    context "when the event does not exist" do
      it "returns 404", :aggregate_failures do
        post '/events/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event does not exist"
      end
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end

  describe 'PATCH /events/:id/cancel' do
    subject { patch '/events/1/cancel', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:event) { create(:event, id: 1) }
    let(:mailer) { instance_double(EventCancelledMailer, call: OpenStruct.new(deliver_now: true)) }

    before do
      Participant.create(event: event, user: current_user)
    end

    it "returns 200 plus the event without participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("events")
      expect(json_response['data']).to have_attribute(:status).with_value("cancelled")
      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included']).to be nil
    end

    it "changes the status of the event in the database" do
      expect { subject }
        .to change { Event.find(1).status }
          .from("posted").to("cancelled")
    end

    it "uses the correct mailer" do
      allow(EventCancelledMailer)
        .to receive(:with).with(user: current_user, event: event)
        .and_return(mailer)

      expect(mailer).to receive(:call).once

      subject
    end

    context "when the status is already cancelled" do
      let(:event) { create(:event, id: 1, status: "cancelled") }

      it "returns 200 plus the event without participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("events")
        expect(json_response['data']).to have_attribute(:status).with_value("cancelled")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included']).to be nil
      end

      it "does not change the status of the event in the database" do
        expect { subject }
          .not_to change { Event.find(1).status }
      end
    end

    context "when the event does not exist" do
      it "returns 404", :aggregate_failures do
        post '/events/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This event does not exist"
      end
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end
end