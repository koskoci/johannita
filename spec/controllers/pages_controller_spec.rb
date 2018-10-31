require 'rails_helper'

RSpec.describe PagesController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /pages' do
    before do
      create_list(:page, 2)
    end

    it "sends a list of pages", :aggregate_failures do
      get '/api/pages', headers: get_headers(current_user)

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to all have_type("pages")
    end
  end

  describe 'GET /pages/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the page exists" do
      before do
        create(:page, id: 1)
      end

      context "when there is no attachment" do
        it "sends a single page", :aggregate_failures do
          get '/api/pages/1', headers: headers

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("pages")
          expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
          expect(json_response['data']).to have_relationship(:images)
        end
      end

      context "when there is an attachment" do
        let(:image_fixture) do
          fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
        end

        before do
          Post.find(1).images.attach(image_fixture)
        end

        it "sends a single page with all included images", :aggregate_failures do
          get '/api/pages/1', headers: headers

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("pages")
          expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
          expect(json_response['data']).to have_relationship(:images)
          expect(json_response['included'])
            .to include(have_type('images').and have_attributes(:id, :url, :content_type, :byte_size))
        end
      end
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        get '/api/pages/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This page does not exist"
      end
    end
  end

  describe 'POST /pages' do
    subject { page '/api/pages', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "pages",
          "attributes": {
            "title": "First page title",
            "content": "First page content"
          }
        }
      }
    end
    let(:headers) { page_headers(current_user) }

    context "when current user is not an admin" do
      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when current user is an admin" do
      let(:current_user) { create(:user, admin: true) }

      it "returns 204" do
        subject

        expect(response.status).to eq 204
      end

      it "creates a Post in the database" do
        expect { subject }
          .to change(Post, :count).by(+1)
      end
    end
  end

  describe 'PATCH /pages/:id' do
    subject { patch '/api/pages/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "pages",
          "attributes": {
            "title": "Updated page title",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:page) { create(:page, id: 1) }
    let(:headers) { page_headers(current_user) }

    before do
      current_user
      page
    end

    it "returns 200" do
      subject

      expect(response.status).to eq 200
    end

    it "does not create a new Post in the database" do
      expect { subject }.not_to change(Post, :count)
    end

    it "changes the Post in the database" do
      expect { subject }
        .to change { Post.find(1).title }
        .from("My page").to("Updated page title")
      expect { subject }
        .not_to change { Post.find(1).content }
    end

    it "returns the updated Post" do
      subject

      expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to have_type("pages")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/api/pages/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This page does not exist"
      end
    end
  end

  describe 'DELETE /pages/:id' do
    subject { delete '/api/pages/1', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:page) { create(:page, id: 1) }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      page
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it "deletes the Post from the database" do
      expect { subject }.to change(Post, :count).by(-1)
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/api/pages/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This page does not exist"
      end
    end
  end

  describe 'POST /pages/:id/images' do
    subject { page '/api/pages/1/images', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:my_page) { create(:page, id: 1) }
    let(:headers) { page_headers(current_user) }
    let(:body) { { "page": { "image": image_fixture } } }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before do
      current_user
      my_page
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    context "when current user is not an admin", :aggregate_failures do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the page does not exist" do
      it "returns 404", :aggregate_failures do
        page '/api/pages/1337/images', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This page does not exist"
      end
    end
  end
end
