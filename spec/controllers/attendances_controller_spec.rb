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

  describe 'GET /attendances' do
    let(:admin) { create(:user, admin: true) }
    let(:headers) { get_headers(admin) }

    context "when both course_event_id and course_id are missing" do
      subject { get '/api/attendances', headers: headers }

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "Please specify either course_id or course_event_id"
      end
    end

    context "when both course_event_id and course_id are given" do
      subject do
        get '/api/attendances?course_id=1&course_event_id=1', headers: headers
      end

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "Please specify either course_id or course_event_id"
      end
    end

    context "when course_id or course_event_id is given" do
      subject { get '/api/attendances?course_id=1', headers: headers }

      context "when the course does not exist" do
        it "returns 400 with an error message" do
          subject

          expect(response.status).to eq 400
          expect(json_response['error']).to eq "This course does not exist"
        end
      end

      context "when the course exists" do
        let(:course) { create :course, id: 1 }

        before { course }

        context "when there are no attendances" do
          it "returns an empty list" do
            subject

            expect(response.status).to eq 200
            expect(json_response['data']).to eq []
          end
        end

        context "when there are attendances" do
          let(:course_event_1) { create :course_event, course: course }
          let(:course_event_2) { create :course_event, course: course }
          let(:participant) do
            create :participant, user: current_user, course: course
          end
          let(:attendance_1) do
            create :attendance, course_event: course_event_1, participant: participant
          end
          let(:attendance_2) do
            create :attendance, course_event: course_event_2, participant: participant
          end

          before do
            attendance_1
            attendance_2
          end

          context "when the user is not logged in" do
            let(:headers) { get_headers_without_token }

            it_behaves_like "returns 401 unauthenticated with error message"
          end

          context "when current user is not an admin" do
            let(:headers) { get_headers(current_user) }

            it_behaves_like "returns 403 unauthorized with error message"
          end

          context "when course_id is given" do
            it "sends the list of attendances for the course", :aggregate_failures do
              get '/api/attendances?course_id=1', headers: headers

              expect(response.status).to eq 200
              expect(json_response['data'].count).to eq(2)
              expect(json_response['data']).to all have_type("attendances")
              expect(json_response['data'].first).to have_id(attendance_1.id.to_s)
              expect(json_response['data'].last).to have_id(attendance_2.id.to_s)
            end
          end

          context "when course_event_id is given" do
            it "sends the list of attendances for the course event", :aggregate_failures do
              get "/api/attendances?course_event_id=#{course_event_1.id}", headers: headers

              expect(response.status).to eq 200
              expect(json_response['data']).to have_type("attendances")
              expect(json_response['data']).to have_id(attendance_1.id.to_s)
            end
          end
        end
      end
    end
  end
end
