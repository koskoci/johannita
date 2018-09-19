require 'rails_helper'

RSpec.describe CourseEventsController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /course_events' do
    subject { get '/course_events', headers: get_headers(current_user) }

    let(:course_event) { create(:course_event) }
    let(:another_course_event) { create(:course_event) }
    let(:service_object) { instance_double(CourseEvents::CanApply, call: true) }

    before do
      course_event
      another_course_event
    end

    it "uses the correct service for can_apply", :aggregate_failures do
      expect(CourseEvents::CanApply).to receive(:new).with(current_user, course_event).and_return(service_object)
      expect(CourseEvents::CanApply).to receive(:new).with(current_user, another_course_event).and_return(service_object)

      subject

      expect(json_response['data']).to all have_attribute(:can_apply).with_value(true)
    end

    it "sends a list of course_events", :aggregate_failures do
      subject

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_type("course_events")
      expect(json_response['data']).to all have_attributes(:title, :category, :date, :created_at, :updated_at, :status, :apply_by, :can_apply)
      expect(json_response['data']).to all have_relationship(:participants)
    end
  end

  describe 'GET /course_events/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the course_event exists" do
      subject { get '/course_events/1', headers: headers }

      let(:course_event) { create(:course_event, id: 1) }
      let(:service_object) { instance_double(CourseEvents::CanApply, call: true) }

      before do
        course_event
      end

      it "uses the correct service for can_apply", :aggregate_failures do
        expect(CourseEvents::CanApply).to receive(:new).with(current_user, course_event).and_return(service_object)

        subject

        expect(json_response['data']).to have_attribute(:can_apply).with_value(true)
      end

      context "when there is no attachment" do
        it "sends a single course_event", :aggregate_failures do
          subject

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("course_events")
          expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status, :apply_by, :can_apply)
          expect(json_response['data']).to have_relationship(:participants)
        end
      end

      context "when there are participants" do
        let(:other_user) { create(:user) }

        before do
          Participant.create(course_event: course_event, user: other_user)
          Participant.create(course_event: course_event, user: current_user)
        end

        it "sends a single course_event with all included participants", :aggregate_failures do
          subject

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("course_events")
          expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status, :apply_by, :can_apply)
          expect(json_response['data']).to have_relationship(:participants)
          expect(json_response['included'].size).to eq 2
          expect(json_response['included'])
            .to include(have_type('participants').and have_attributes(:name, :email, :attended, :passed))
        end
      end
    end

    context "when the course_event does not exist" do
      it "returns 404", :aggregate_failures do
        get '/course_events/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course event does not exist"
      end
    end
  end

  describe 'POST /course_events' do
    subject { post '/course_events', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "course_events",
          "attributes": {
            "title": "First course_event title",
            "content": "First course_event content",
            "category": "kismama"
          }
        }
      }
    end
    let(:headers) { post_headers(current_user) }

    before { create(:course_category) }

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "returns 204", :aggregate_failures do
        subject

        expect(response.status).to eq 204
      end

      it "creates a CourseEvent in the database" do
        expect { subject }
          .to change(CourseEvent, :count).by(+1)
      end

      context "when the course category does not exist" do
        let(:body) do
          {
            "data": {
              "type": "course_events",
              "attributes": {
                "title": "First course_event title",
                "content": "First course_event content",
                "category": "Zsakpakolo-tanfolyam"
              }
            }
          }
        end

        it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "This course category does not exist"
        end
      end
    end
  end

  describe 'PATCH /course_events/:id' do
    subject { patch '/course_events/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "course_events",
          "attributes": {
            "title": "Updated course_event title",
            "category": "Mentoapolo-tanfolyam",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:course_event) { create(:course_event, id: 1) }
    let(:headers) { post_headers(current_user) }
    let(:another_course_category) { create(:course_category, category: "Mentoapolo-tanfolyam") }

    before do
      current_user
      course_event
      another_course_category
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new CourseEvent in the database" do
      expect { subject }.not_to change(CourseEvent, :count)
    end

    it "changes the CourseEvent in the database" do
      expect { subject }
        .to change { CourseEvent.find(1).title }
        .from("My course_event").to("Updated course_event title")
      expect { subject }
        .not_to change { CourseEvent.find(1).course_category }
    end

    it "returns the updated CourseEvent" do
      subject

      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status, :apply_by, :can_apply)
      expect(json_response['data']).to have_attribute(:category).with_value("kismama")
      expect(json_response['data']).to have_attribute(:can_apply).with_value(true)
      expect(json_response['data']).to have_type("course_events")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the course event does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/course_events/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course event does not exist"
      end
    end
  end

  describe 'POST /course_events/:id/apply' do
    subject { post '/course_events/1/apply', headers: headers }

    let(:headers) { post_headers(current_user) }
    let(:course_event) { create(:course_event, id: 1) }

    before do
      current_user
      course_event
    end

    it "returns 200 plus the course_event with participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("course_events")
      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status, :apply_by, :can_apply)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included'].size).to eq 1
      expect(json_response['included'])
        .to include(have_type('participants').and have_attributes(:name, :email, :attended, :passed))
    end

    it "creates an Participant in the database" do
      expect { subject }
        .to change(Participant, :count).by(+1)
    end

    context "when the same participant already exists" do
      before { Participant.create(course_event: course_event, user: current_user) }

      it "returns 200 plus the course_event with participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("course_events")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at, :status, :apply_by, :can_apply)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included'].size).to eq 1
        expect(json_response['included'])
          .to include(have_type('participants').and have_attributes(:name, :email, :attended, :passed))
      end
    end

    context "when the course_event does not exist" do
      it "returns 404", :aggregate_failures do
        post '/course_events/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course event does not exist"
      end
    end
  end

  describe 'PATCH /course_events/:id/confirm' do
    subject { patch '/course_events/1/confirm', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:course_event) { create(:course_event, id: 1) }
    let(:mailer) { instance_double(EventConfirmedMailer, call: OpenStruct.new(deliver_now: true)) }

    before do
      Participant.create(course_event: course_event, user: current_user)
    end

    it "returns 200 plus the course_event without participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("course_events")
      expect(json_response['data']).to have_attribute(:status).with_value("confirmed")
      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included']).to be nil
    end

    it "changes the status of the course_event in the database" do
      expect { subject }
        .to change { CourseEvent.find(1).status }
          .from("posted").to("confirmed")
    end

    it "uses the correct worker" do
      expect(EventConfirmedWorker)
        .to receive(:perform_async).with(course_event.id)

      subject
    end

    context "when the status is already confirmed" do
      let(:course_event) { create(:course_event, id: 1, status: "confirmed") }

      it "returns 200 plus the course_event without participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("course_events")
        expect(json_response['data']).to have_attribute(:status).with_value("confirmed")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included']).to be nil
      end

      it "does not change the status of the course_event in the database" do
        expect { subject }
          .not_to change { CourseEvent.find(1).status }
      end
    end

    context "when the course_event does not exist" do
      it "returns 404", :aggregate_failures do
        post '/course_events/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course event does not exist"
      end
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end

  describe 'PATCH /course_events/:id/cancel' do
    subject { patch '/course_events/1/cancel', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:course_event) { create(:course_event, id: 1) }
    let(:mailer) { instance_double(EventCancelledMailer, call: OpenStruct.new(deliver_now: true)) }

    before do
      Participant.create(course_event: course_event, user: current_user)
    end

    it "returns 200 plus the course_event without participants" do
      subject

      expect(response.status).to eq 200
      expect(json_response['data']).to have_type("course_events")
      expect(json_response['data']).to have_attribute(:status).with_value("cancelled")
      expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
      expect(json_response['data']).to have_relationship(:participants)
      expect(json_response['included']).to be nil
    end

    it "changes the status of the course_event in the database" do
      expect { subject }
        .to change { CourseEvent.find(1).status }
          .from("posted").to("cancelled")
    end

    it "uses the correct worker" do
      expect(EventCancelledWorker)
        .to receive(:perform_async).with(course_event.id)

      subject
    end

    context "when the status is already cancelled" do
      let(:course_event) { create(:course_event, id: 1, status: "cancelled") }

      it "returns 200 plus the course_event without participants" do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("course_events")
        expect(json_response['data']).to have_attribute(:status).with_value("cancelled")
        expect(json_response['data']).to have_attributes(:title, :category, :date, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:participants)
        expect(json_response['included']).to be nil
      end

      it "does not change the status of the course_event in the database" do
        expect { subject }
          .not_to change { CourseEvent.find(1).status }
      end
    end

    context "when the course_event does not exist" do
      it "returns 404", :aggregate_failures do
        post '/course_events/1337/apply', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This course event does not exist"
      end
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end
end