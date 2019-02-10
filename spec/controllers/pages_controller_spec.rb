require 'rails_helper'

RSpec.describe PagesController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /pages' do
    before do
      create_list(:page, 2)
    end

    it "sends a list of pages", :aggregate_failures do
      get '/api/pages', headers: get_headers_without_token

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_type("pages")
      expect(json_response['data']).to all have_attributes(:short_name, :content)
    end
  end

  describe 'GET /pages/:short_name' do
    let(:headers) { get_headers_without_token }

    context "when the page exists" do
      before do
        create(:page, short_name: "short_foo")
      end

      context "when there is no attachment" do
        it "sends a single page", :aggregate_failures do
          get '/api/pages/short_foo', headers: headers

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("pages")
          expect(json_response['data']).to have_relationship('attachments')
          expect(json_response['data']).to have_attributes(:short_name, :content)
        end
      end

      context "when there are attachments" do
        let(:pdf_fixture) do
          fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
        end

        before do
          Page.find_by_short_name("short_foo").attachments.attach(pdf_fixture)
          Page.find_by_short_name("short_foo").attachments.last
            .update(description: "First pdf")
          Page.find_by_short_name("short_foo").attachments.attach(pdf_fixture)
          Page.find_by_short_name("short_foo").attachments.last
            .update(description: "Second pdf")
        end

        it "sends a single page with all attachments included", :aggregate_failures do
          get '/api/pages/short_foo', headers: headers

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("pages")
          expect(json_response['data']).to have_attributes(:short_name, :content)
          expect(json_response['data']).to have_relationship("attachments")
          expect(json_response['included'].size).to eq 2
          expect(json_response['included'])
            .to include(have_type('attachments')
            .and have_attributes(:id, :url, :content_type, :byte_size, :description))
          expect(json_response['included'].first)
            .to have_attribute(:description).with_value("First pdf")
          expect(json_response['included'].last)
            .to have_attribute(:description).with_value("Second pdf")
        end
      end
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        get '/api/pages/totally_drunk', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "No page exists with this short name"
      end
    end
  end

  describe 'POST /pages' do
    subject { post '/api/pages', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "pages",
          "attributes": {
            "short_name": "foo_bar",
            "content": "First page content"
          }
        }
      }
    end
    let(:headers) { post_headers(current_user) }

    context "when the user is not logged in" do
      let(:headers) { post_headers_without_token }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      context "when the short_name is taken" do
        before do
          create(:page, short_name: "foo_bar")
        end

        it "returns 400 with an error message" do
          subject

          expect(response.status).to eq 400
          expect(json_response['error']).to eq "This short name is already taken"
        end
      end

      it "returns 204" do
        subject

        expect(response.status).to eq 204
      end

      it "creates a Page in the database" do
        expect { subject }
          .to change(Page, :count).by(+1)
      end
    end
  end

  describe 'POST /pages/:short_name/attachments' do
    subject do
      post '/api/pages/short_foo/attachments', params: body, headers: headers
    end

    let(:pdf_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'pdf.pdf'), 'application/pdf')
    end

    let(:body) {
      {
        "file": pdf_fixture,
        "description": "This is my life story"
      }
    }

    let(:headers) { post_headers(current_user) }

    context "when the user is not logged in" do
      let(:headers) { post_headers_without_token }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      before { create(:page, short_name: "short_foo") }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      context "when the page does not exist" do
        before do
          create(:page, short_name: "foo_bar")
        end

        it "returns 404 with an error message" do
          subject

          expect(response.status).to eq 404
          expect(json_response['error']).to eq "No page exists with this short name"
        end
      end

      context "when the page exists" do
        before { create(:page, short_name: "short_foo") }

        it "returns 201" do
          subject

          expect(response.status).to eq 201
        end

        it 'attaches the file' do
          expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
            .and change { Page.find_by_short_name("short_foo").attachments.attached? }.from(false).to(true)
        end

        it 'saves the description' do
          subject

          expect(Page.find_by_short_name("short_foo").attachments.first.description)
            .to eq("This is my life story")
        end
      end
    end
  end

  describe 'PATCH /pages/:short_name' do
    subject { patch '/api/pages/short_foo', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "pages",
          "attributes": {
            "content": "Updated page content",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:page) { create(:page, short_name: "short_foo") }
    let(:headers) { post_headers(current_user) }

    before do
      current_user
      page
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new Page in the database" do
      expect { subject }.not_to change(Page, :count)
    end

    it "changes the Page in the database" do
      expect { subject }
        .to change { Page.find_by_short_name("short_foo").content }
        .from("My little content\nIn two rows").to("Updated page content")
    end

    it "returns the updated Page" do
      subject

      expect(json_response['data']).to have_attributes(:short_name, :content)
      expect(json_response['data']).to have_type("pages")
    end

    context "when the user is not logged in" do
      let(:headers) { post_headers_without_token }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/api/pages/too_drunk_to_dance', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "No page exists with this short name"
      end
    end
  end

  describe 'DELETE /pages/:short_name' do
    subject { delete '/api/pages/short_foo', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:page) { create(:page, short_name: "short_foo") }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      page
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it "deletes the Page from the database" do
      expect { subject }.to change(Page, :count).by(-1)
    end

    context "when the user is not logged in" do
      let(:headers) { get_headers_without_token }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/api/pages/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "No page exists with this short name"
      end
    end
  end
end
