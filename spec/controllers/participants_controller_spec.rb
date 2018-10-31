require 'rails_helper'

RSpec.describe ParticipantsController, type: :request do
  let(:current_user) { create(:user, admin: true) }

  before { current_user }

  describe 'GET /participants' do
    context "when the course_id is missing" do
      subject { get '/api/participants', headers: get_headers(current_user) }

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "Please specify course"
      end
    end

    context "when the course_id is given" do
      subject { get '/api/participants?course_id=1', headers: headers }

      let(:headers) { get_headers(current_user) }

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

        context "when the course is cancelled" do
          let(:course) { create :course, id: 1, status: "cancelled" }

          it "returns 400 with an error message" do
            subject

            expect(response.status).to eq 400
            expect(json_response['error']).to eq "This course has been cancelled"
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
          before { create_list :participant, 2, course: course }

          it "sends the list of participants", :aggregate_failures do
            subject

            expect(response.status).to eq 200
            expect(json_response['data'].count).to eq(2)
            expect(json_response['data']).to all have_attributes(:name, :email, :attended, :passed)
            expect(json_response['data']).to all have_attribute(:name).with_value("Bar Foo")
            expect(json_response['data']).to all have_type("participants")
          end

          context "when the user is not logged in" do
            let(:headers) { get_headers_without_token }

            it_behaves_like "returns 401 unauthenticated with error message"
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
    subject { patch '/api/participants/1', params: body.to_json, headers: headers }

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
      expect(json_response['data']).to have_attribute(:name).with_value("Bar Foo")
      expect(json_response['data']).to have_type("participants")
      expect(json_response['data']).to have_id("1")
    end

    context "when the user is not logged in" do
      let(:headers) { post_headers_without_token }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the participant does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/api/participants/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This participant does not exist"
      end
    end

    context "when the course is cancelled" do
      let(:participant) { create :participant, id: 1, course: course }
      let(:course) { create :course, id: 1, status: "cancelled" }

      it "returns 400 with an error message" do
        subject

        expect(response.status).to eq 400
        expect(json_response['error']).to eq "This course has been cancelled"
      end
    end
  end
end
