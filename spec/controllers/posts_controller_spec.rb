require 'rails_helper'

RSpec.describe PostsController, :type => :request do
  let(:user) { create(:user, id: 1) }

  before do
    user
  end


  describe 'GET /posts' do
    before do
      create(:post, id: 1, title: "foo", content: "bar")
      create(:post, id: 2, title: "fee", content: "baz")
    end

    it "sends a list of posts", :aggregate_failures do
      get '/posts', headers: get_headers(user)

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to all have_type("posts")
    end
  end

  describe 'GET /posts/:id' do
    context "when the post exists" do
      before do
        create(:post, id: 1, title: "foo", content: "bar")
      end

      it "sends a single post", :aggregate_failures do
        get '/posts/1', headers: get_headers(user)

        expect(response.status).to eq 200
        expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
        expect(json_response['data']).to have_type("posts")
      end
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        get '/posts/1337', headers: get_headers(user)

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'POST /posts' do
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

    context "when current user is not an admin" do
      it "returns 403" do
        post '/posts', params: body.to_json, headers: post_headers(user)

        expect(response.status).to eq 403
        expect(json_response['error']).to eq "Not Permitted"
      end
    end

    context "when current user is an admin" do
      let(:user) { create(:user, admin: true) }

      it "returns 201" do
        post '/posts', params: body.to_json, headers: post_headers(user)

        expect(response.status).to eq 201
      end

      it "creates a Post in the database" do
        expect { post '/posts', params: body.to_json, headers: post_headers(user) }
          .to change(Post, :count).by(+1)
      end

      it "returns the created Post" do
        post '/posts', params: body.to_json, headers: post_headers(user)

        expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
        expect(json_response['data']).to have_type("posts")
        expect(json_response['data']['id']).not_to be nil
      end
    end
  end

  describe 'PATCH /posts/:id' do
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
    let(:user) { create(:user, admin: true) }
    let(:post) { create(:post, id: 1) }
    let(:headers) { post_headers(user) }

    before do
      user
      post
    end

    it "returns 200" do
      patch '/posts/1', params: body.to_json, headers: headers

      expect(response.status).to eq 200
    end

    it "does not create a new Post in the database" do
      expect { patch '/posts/1', params: body.to_json, headers: headers }
        .not_to change(Post, :count)
    end

    it "changes the Post in the database" do
      expect { patch '/posts/1', params: body.to_json, headers: headers }
        .to change { Post.find(1).title }
        .from("My post").to("Updated post title")
      expect { patch '/posts/1', params: body.to_json, headers: headers }
        .not_to change { Post.find(1).content }
    end

    it "returns the updated Post" do
      patch '/posts/1', params: body.to_json, headers: headers

      expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to have_type("posts")
      expect(json_response['data']).to have_id("1")
    end

    context "when current user is not an admin" do
      let(:user) { create(:user) }

      it "returns 403" do
        patch '/posts/1', params: body.to_json, headers: post_headers(user)

        expect(response.status).to eq 403
        expect(json_response['error']).to eq "Not Permitted"
      end
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/posts/1337', params: body.to_json, headers: post_headers(user)

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'DELETE /posts/:id' do
    let(:user) { create(:user, admin: true) }
    let(:post) { create(:post, id: 1) }
    let(:headers) { get_headers(user) }

    before do
      user
      post
    end

    it "returns 204" do
      delete '/posts/1', headers: headers

      expect(response.status).to eq 204
    end

    it "deletes the Post from the database" do
      expect { delete '/posts/1', headers: headers }
        .to change(Post, :count).by(-1)
    end

    context "when current user is not an admin" do
      let(:user) { create(:user) }

      it "returns 403" do
        delete '/posts/1', headers: headers

        expect(response.status).to eq 403
        expect(json_response['error']).to eq "Not Permitted"
      end
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

    let(:user) { create(:user, admin: true) }
    let(:my_post) { create(:post, id: 1) }
    let(:headers) { post_headers(user) }
    let(:body) { { "post": { "image": image_fixture } } }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before do
      user
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
      let(:user) { create(:user) }

      it "returns 403" do
        subject

        expect(response.status).to eq 403
        expect(json_response['error']).to eq "Not Permitted"
      end
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
