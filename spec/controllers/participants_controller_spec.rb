require 'rails_helper'

RSpec.describe ParticipantsController, type: :request do
  let(:current_user) { create(:user, admin: true) }

  before { current_user }

  describe 'GET /participants' do
    context "when the course_event_id is missing" do
      subject { get '/participants', headers: get_headers(current_user) }

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "Please specify course event"
      end
    end

    context "when the course_event_id is given" do
      subject { get '/participants?course_event_id=1', headers: get_headers(current_user) }

      context "when the course_event does not exist" do
        it "returns 400 with an error message" do
          subject

          expect(response.status).to eq 400
          expect(json_response['error']).to eq "This course event does not exist"
        end
      end

      context "when the course_event exists" do
        let(:course_event) { create :course_event, id: 1 }

        before { course_event }

        context "when the course event is cancelled" do
          let(:course_event) { create :course_event, id: 1, status: "cancelled" }

          it "returns 400 with an error message" do
            subject

            expect(response.status).to eq 400
            expect(json_response['error']).to eq "This course event has been cancelled"
          end
        end

        context "when there are no participants" do
          it "returns an empty list" do
            subject

            expect(response.status).to eq 200
            expect(json_response['data']).to eq []
          end
        end

        context "when there are participants" do
          before { create_list :participant, 2, course_event: course_event }

          it "sends the list of participants", :aggregate_failures do
            subject

            expect(response.status).to eq 200
            expect(json_response['data'].count).to eq(2)
            expect(json_response['data']).to all have_attributes(:name, :email, :attended, :passed)
            expect(json_response['data']).to all have_type("participants")
          end

          context "when current user is not an admin" do
            let(:current_user) { create(:user) }

            it_behaves_like "returns 403 unauthorized with error message"
          end
        end
      end
    end
  end

  describe 'PATCH /participants/:id' do
    subject { patch '/participants/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "participants",
          "attributes": {
            "attended": true
          }
        }
      }
    end
    let(:participant) { create(:participant, id: 1) }
    let(:headers) { post_headers(current_user) }

    before do
      participant
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new Participant in the database" do
      expect { subject }.not_to change(Participant, :count)
    end

    it "changes the Participant in the database" do
      expect { subject }
        .to change { Participant.find(1).attended }
        .from(nil).to(true)
      expect { subject }
        .not_to change { Participant.find(1).passed }
    end

    it "returns the updated Participant" do
      subject

      expect(json_response['data']).to have_attributes(:name, :email, :attended, :passed)
      expect(json_response['data']).to have_attribute(:attended).with_value(true)
      expect(json_response['data']).to have_type("participants")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the participant does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/participants/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This participant does not exist"
      end
    end

    context "when the course event is cancelled" do
      let(:participant) { create :participant, id: 1, course_event: course_event }
      let(:course_event) { create :course_event, id: 1, status: "cancelled" }

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "This course event has been cancelled"
      end
    end
  end
end
