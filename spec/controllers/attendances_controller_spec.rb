require 'rails_helper'

RSpec.describe AttendancesController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'POST /attendances' do
    subject { post '/api/attendances', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "attendances",
          "relationships": {
            "participant": {
              "data": {
                "type": "participants",
                "id": participant.id.to_s
              }
            },
            "course_event": {
              "data": {
                "type": "course_events",
                "id": course_event.id.to_s
              }
            }
          }
        }
      }
    end

    let(:headers) { post_headers(current_user) }
    let(:course_event) { create(:course_event) }
    let(:participant) { create(:participant) }

    context "when the user is not logged in" do
      let(:headers) { post_headers_without_token }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "returns 200", :aggregate_failures do
        subject

        expect(response.status).to eq 200
      end

      it "returns the created attendance" do
        subject

        expect(json_response['data']).to have_type("attendances")
        expect(json_response['data']['id']).not_to be_nil
        expect(json_response['data']).to have_relationships("course_event", "participant")
      end

      it "creates the Attendance in the database" do
        expect { subject }.to change(Attendance, :count).by(+1)
      end

      it "saves the attendance correctly" do
        subject

        first = Attendance.first
        expect(first.course_event).to eq course_event
        expect(first.participant).to eq participant
      end
    end
  end

  describe 'DELETE /attendances/:id' do
    subject { delete '/api/attendances/1', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:attendance) { create(:attendance, id: 1) }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      attendance
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it "deletes the Attendance from the database" do
      expect { subject }.to change(Attendance, :count).by(-1)
    end

    context "when the user is not logged in" do
      subject { delete '/api/attendances/1' }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the attendance does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/api/attendances/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This attendance does not exist"
      end
    end
  end
end
