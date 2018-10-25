require 'rails_helper'

RSpec.describe CourseEventsController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /course_events' do
    subject { get '/course_events', headers: get_headers(current_user) }

    let(:course_event) { create(:course_event) }
    let(:another_course_event) { create(:course_event) }

    before do
      course_event
      another_course_event
    end

    it "sends a list of course_events", :aggregate_failures do
      subject

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_type("course_events")
      expect(json_response['data']).to all have_attributes(:date, :title, :created_at, :updated_at)
      expect(json_response['data']).to all have_relationship(:course)
    end
  end

  describe 'GET /course_events/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the course_event exists" do
      subject { get '/course_events/1', headers: headers }

      let(:course_event) { create(:course_event, id: 1) }

      before do
        course_event
      end

      it "sends a single course_event with all included participants", :aggregate_failures do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type("course_events")
        expect(json_response['data']).to have_attributes(:date, :title, :created_at, :updated_at)
        expect(json_response['data']).to have_relationship(:course)
        expect(json_response.dig('data', 'relationships', 'course', 'data', 'id')).not_to be_nil
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
            "date": "2018/01/01"
          },
          "relationships": {
            "course": {
              "data": {
                "type": "courses",
                "id": course.id.to_s
              }
            }
          }
        }
      }
    end
    let(:headers) { post_headers(current_user) }
    let(:course) { create(:course) }

    before { course }

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

      context "when the course does not exist" do
        let(:body) do
          {
            "data": {
              "type": "course_events",
              "attributes": {
                "title": "First course_event title",
                "date": "2018/01/01"
              },
              "relationships": {
                "course": {
                  "data": {
                    "type": "courses",
                    "id": "1337"
                  }
                }
              }
            }
          }
        end

        it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "This course does not exist"
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
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:course_event) { create(:course_event, id: 1, course: course) }
    let(:course) { create(:course) }

    before do
      current_user
      course_event
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
        .not_to change { CourseEvent.find(1).date }
    end

    it "returns the updated CourseEvent" do
      subject

      expect(json_response['data']).to have_attributes(:date, :title, :created_at, :updated_at)
      expect(json_response['data']).to have_attribute(:title).with_value("Updated course_event title")
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
end
