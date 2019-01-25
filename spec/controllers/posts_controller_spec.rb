require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:current_user) { create(:user) }

  before { current_user }

  describe 'GET /posts' do
    before do
      create_list(:post, 2)
    end

    it "sends a list of posts", :aggregate_failures do
      get '/api/posts'

      expect(response.status).to eq 200
      expect(json_response['data'].count).to eq(2)
      expect(json_response['data']).to all have_attributes(:title, :content, :created_at, :updated_at)
      expect(json_response['data']).to all have_type("posts")
    end
  end

  describe 'GET /posts/:id' do
    context "when the post exists" do
      before do
        create(:post, id: 1)
      end

      context "when there is no attachment" do
        it "sends a single post", :aggregate_failures do
          get '/api/posts/1'

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("posts")
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

        it "sends a single post with all included images", :aggregate_failures do
          get '/api/posts/1'

          expect(response.status).to eq 200
          expect(json_response['data']).to have_type("posts")
          expect(json_response['data']).to have_attributes(:title, :content, :created_at, :updated_at)
          expect(json_response['data']).to have_relationship(:images)
          expect(json_response['included'])
            .to include(have_type('images').and have_attributes(:id, :url, :content_type, :byte_size))
        end
      end
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        get '/api/posts/1337'

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'POST /posts' do
    subject { post '/api/posts', params: body.to_json, headers: headers }

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

    context "when the user is not logged in" do
      subject { post '/api/posts', params: body.to_json }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

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

  describe 'PATCH /posts/:id' do
    subject { patch '/api/posts/1', params: body.to_json, headers: headers }

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

    context "when the user is not logged in" do
      subject { patch '/api/posts/1', params: body.to_json }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        patch '/api/posts/1337', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
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
  end

  describe 'DELETE /posts/:id' do
    subject { delete '/api/posts/1', headers: headers }

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

    context "when the user is not logged in" do
      subject { delete '/api/posts/1' }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin" do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        delete '/api/posts/1337', headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end

  describe 'POST /posts/:id/images' do
    subject { post '/api/posts/1/images', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:my_post) { create(:post, id: 1) }
    let(:headers) { post_headers(current_user) }
    let(:body) { { "image": image_fixture } }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before do
      current_user
      my_post
    end

    it "returns 204" do
      subject

      expect(response.status).to eq 204
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    context "when the user is not logged in" do
      subject { post '/api/posts/1/images', params: body }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin", :aggregate_failures do
      let(:current_user) { create(:user) }

      it_behaves_like "returns 403 unauthorized with error message"
    end

    context "when the post does not exist" do
      it "returns 404", :aggregate_failures do
        post '/api/posts/1337/images', params: body.to_json, headers: headers

        expect(response.status).to eq 404
        expect(json_response['error']).to eq "This post does not exist"
      end
    end
  end
end
