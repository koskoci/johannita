require 'rails_helper'

RSpec.describe PostsController, :type => :request do
  let(:current_user) { create(:user, id: 1) }

  before do
    current_user
  end

  describe 'GET /posts' do
    before do
      create_list(:post, 2)
    end

    it "sends a list of posts", :aggregate_failures do
      get '/posts', headers: get_headers(current_user)

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to all have_type("posts")
    end
  end

  describe 'GET /posts/:id' do
    let(:headers) { get_headers(current_user) }

    context "when the post exists" do
      before do
        create(:post, id: 1)
      end

      it "sends a single post", :aggregate_failures do
        get '/posts/1', headers: headers

        expect(response.status).to eq 200
        expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
        expect(json_response['data']).to have_type("posts")
      end
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        get '/posts/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'POST /posts' do
    subject { post '/posts', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "posts",
          "attributes": {
            "title": "First post title",
            "content": "First post content"
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

      it "creates a Post in the database" do
        expect { subject }
          .to change(Post, :count).by(+1)
      end

      it "returns the created Post" do
        subject

        expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
        expect(json_response['data']).to have_type("posts")
        expect(json_response['data']['id']).not_to be nil
      end
    end
  end

  describe 'PATCH /posts/:id' do
    subject { patch '/posts/1', params: body.to_json, headers: headers }

    let(:body) do
      {
        "data": {
          "type": "posts",
          "attributes": {
            "title": "Updated post title",
          }
        }
      }
    end
    let(:current_user) { create(:user, admin: true) }
    let(:post) { create(:post, id: 1) }
    let(:headers) { post_headers(current_user) }

    before do
      current_user
      post
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
        .from("My post").to("Updated post title")
      expect { subject }
        .not_to change { Post.find(1).content }
    end

    it "returns the updated Post" do
      subject

      expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to have_type("posts")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/posts/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'DELETE /posts/:id' do
    subject { delete '/posts/1', headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:post) { create(:post, id: 1) }
    let(:headers) { get_headers(current_user) }

    before do
      current_user
      post
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

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/posts/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'POST /posts/:id/images' do
    subject { post '/posts/1/images', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:my_post) { create(:post, id: 1) }
    let(:headers) { post_headers(current_user) }
    let(:body) { { "post": { "image": image_fixture } } }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before do
      current_user
      my_post
    end

    it "returns 201" do
      subject

      expect(response.status).to eq 201
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    context "when current user is not an admin", :aggregate_failures do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        post '/posts/1337/images', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end
end
