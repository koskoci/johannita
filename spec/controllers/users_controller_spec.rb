require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /users' do
    subject { get '/users', headers: get_headers(current_user) }

    before do
      create_list(:user, 2)
    end

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "sends a list of users", :aggregate_failures do
        subject

        expect(response.status).to eq 200
        expect(json_response['data'].count).to eq(3)
        expect(json_response['data']).to all have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
        expect(json_response['data']).to all have_relationships('curriculum_vitae', 'cover_letter')
        expect(json_response['data']).to all have_type('users')
      end
    end
  end

  describe 'POST /users' do
    subject { post '/users', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "users",
          "attributes": {
            "email": "foo@bar.com",
            "password": "pwd",
            "first_name": "Balazs",
            "last_name": "Koskoci",
            "pav_until": "2019-01-01",
            "driving_licence_since": "2000-01-01"
          }
        }
      }
    end
    let(:headers) do
      {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      }
    end
    let(:mailer) { instance_double(EmailConfirmationMailer, call: OpenStruct.new(deliver_now: true)) }

    it "returns 204", :aggregate_failures do
      subject

      expect(response.status).to eq 204
    end

    it "creates a User in the database" do
      expect { subject }
        .to change(User, :count).by(+1)
    end

    it "uses the correct service to send an email confirmation request", :aggregate_failures do
      expect(EmailConfirmationMailer)
        .to receive(:with).and_return(mailer)
      expect(mailer).to receive(:call)

      subject
    end

    context "when the email is taken" do
      before { create :user, email: "foo@bar.com" }

      it "returns 400 with an error message" do
      subject

      expect(response.status).to eq 400
      expect(json_response['error']).to eq ["Email has already been taken"]
      end
    end
  end

  describe 'GET /users/:id' do
    subject { get '/users/1', headers: headers }

    let(:headers) { get_headers(current_user) }

    context "when the user exists" do
      before { create(:user, id: 1) }

      context "when current user is not an admin" do
        it_behaves_like "returns 403 unauthorized with error message"
      end

      context "when current user is an admin" do
        let(:current_user) { create(:user, admin: true) }

        xcontext "when at least one of the attachments is missing" do
          it "sends a single user", :aggregate_failures do
            subject

            expect(response.status).to eq 200
            expect(json_response['data']).to have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
            expect(json_response['data']).to have_relationships(:curriculum_vitae, :cover_letter)
            expect(json_response['data']).to have_type('users')
          end
        end

        context "when there is both a cover letter and a cv" do
          let(:pdf_fixture) do
            fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
          end

          before do
            User.find(1).curriculum_vitae.attach(pdf_fixture)
            User.find(1).cover_letter.attach(pdf_fixture)
          end

          it "sends a single user", :aggregate_failures do
            subject

            expect(response.status).to eq 200
            expect(json_response['data']).to have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
            expect(json_response['data']).to have_type('users')
            expect(json_response['data']).to have_relationships('curriculum_vitae', 'cover_letter')
            expect(json_response['included'])
              .to include(have_type('curriculum_vitaes').and have_attributes(:id, :url, :content_type, :byte_size))
              .and include(have_type('cover_letters').and have_attributes(:id, :url, :content_type, :byte_size))
          end
        end
      end
    end

    context "when the user does not exist" do
      it "returns 404", :aggregate_failures do
        get '/users/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This user does not exist"
      end
    end
  end

  describe 'GET /users/me' do
    subject { get '/users/me', headers: headers }

    let(:headers) { get_headers(user) }
    let(:user) { create(:user, id: 1000) }

    before { user }

    xcontext "when there is no attachment" do
      it "sends a single user", :aggregate_failures do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type('users')
        expect(json_response['data']).to have_id("1000")
        expect(json_response['data']).to have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
        expect(json_response['data']).to have_relationships(:curriculum_vitae, :cover_letter)
      end
    end

    context "when there is both a cover letter and a cv" do
      let(:pdf_fixture) do
        fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
      end

      before do
        User.find(1000).curriculum_vitae.attach(pdf_fixture)
        User.find(1000).cover_letter.attach(pdf_fixture)
      end

      it "sends a single user", :aggregate_failures do
        subject

        expect(response.status).to eq 200
        expect(json_response['data']).to have_type('users')
        expect(json_response['data']).to have_id("1000")
        expect(json_response['data']).to have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
        expect(json_response['data']).to have_relationships('curriculum_vitae', 'cover_letter')
        expect(json_response['included'])
          .to include(have_type('curriculum_vitaes').and have_attributes(:id, :url, :content_type, :byte_size))
      end
    end
  end

  describe 'PATCH /users/:id' do
    subject { patch '/users/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "users",
          "attributes": {
            "pav_until": "2019-01-01",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:user) { create(:user, id: 1, pav_until: "2018-01-01") }
    let(:headers) { post_headers(current_user) }

    before { user }

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new User in the database" do
      expect { subject }.not_to change(User, :count)
    end

    it "changes the User in the database" do
      expect { subject }
        .to change { User.find(1).pav_until }
        .from(Date.parse("2018-01-01")).to(Date.parse("2019-01-01"))
      expect { subject }
        .not_to change { User.find(1).driving_licence_since }
    end

    it "returns the updated User" do
      subject

      expect(json_response['data']).to have_type('users')
      expect(json_response['data']).to have_id("1")
      expect(json_response['data']).to have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
      expect(json_response['data']).to have_relationships('curriculum_vitae', 'cover_letter')
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the user does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/users/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This user does not exist"
      end
    end
  end

  describe 'PATCH /users/me' do
    subject { patch '/users/me', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "users",
          "attributes": {
            "pav_until": "2019-01-01",
          }
        }
      }
    end
    let(:user) { create(:user, id: 1, pav_until: "2018-01-01") }
    let(:headers) { post_headers(user) }

    before { user }

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new User in the database" do
      expect { subject }.not_to change(User, :count)
    end

    it "changes the User in the database" do
      expect { subject }
        .to change { User.find(1).pav_until }
        .from(Date.parse("2018-01-01")).to(Date.parse("2019-01-01"))
      expect { subject }
        .not_to change { User.find(1).driving_licence_since }
    end

    it "returns the updated User" do
      subject

      expect(json_response['data']).to have_type('users')
      expect(json_response['data']).to have_id("1")
      expect(json_response['data']).to have_attributes(:first_name, :last_name, :email, :pav_until, :driving_licence_since)
      expect(json_response['data']).to have_relationships('curriculum_vitae', 'cover_letter')
    end
  end

  describe 'DELETE /users/:id' do
    subject { delete '/users/1', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:user) { create(:user, id: 1) }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      user
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it "deletes the User from the database" do
      expect { subject }.to change(User, :count).by(-1)
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the user does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/users/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This user does not exist"
      end
    end
  end

  describe 'POST /users/:id/curriculum_vitaes' do
    subject { post '/users/1/curriculum_vitaes', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:user) { create(:user, id: 1) }
    let(:headers) { post_headers(current_user) }
    let(:body) { { "user": { "curriculum_vitae": pdf_fixture } } }
    let(:pdf_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
    end

    before do
      current_user
      user
      User.find(1).cover_letter.attach(pdf_fixture)
    end

    it "returns 201" do
      subject

      expect(response.status).to eq 201
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
        .and change { User.find(1).curriculum_vitae.attached? }.from(false).to(true)
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the user does not exist" do
      it "returns 404", :aggregate_failures do
        post '/users/1337/curriculum_vitaes', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This user does not exist"
      end
    end
  end

  describe 'POST /users/:id/cover_letters' do
    subject { post '/users/1/cover_letters', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:user) { create(:user, id: 1) }
    let(:headers) { post_headers(current_user) }
    let(:body) { { "user": { "cover_letter": pdf_fixture } } }
    let(:pdf_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
    end

    before do
      current_user
      user
      User.find(1).curriculum_vitae.attach(pdf_fixture)
    end

    it "returns 201" do
      subject

      expect(response.status).to eq 201
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
        .and change { User.find(1).cover_letter.attached? }.from(false).to(true)
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the user does not exist" do
      it "returns 404", :aggregate_failures do
        post '/users/1337/cover_letters', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This user does not exist"
      end
    end
  end
end
