require 'rails_helper'

RSpec.describe ImagesController, type: :request do
  describe 'POST /embedded_image' do
    subject { post '/api/embedded_images', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:body) { { "image": image_fixture } }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before { current_user }

    it "returns 201" do
      subject

      expect(response.status).to eq 201
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    context "when the user is not logged in" do
      subject { post '/api/embedded_images', params: body }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin", :aggregate_failures do
      let(:current_user) { create(:user) }

      before { current_user }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end

  describe 'POST /thumbnail' do
    subject { post '/api/thumbnails', params: body, headers: headers }

    let(:current_user) { create(:user, admin: true) }
    let(:headers) { post_headers(current_user) }
    let(:body) { { "image": image_fixture } }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before { current_user }

    it "returns 201" do
      subject

      expect(response.status).to eq 201
    end

    it 'attaches the file' do
      expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
    end

    context "when the user is not logged in" do
      subject { post '/api/thumbnails', params: body }

      it_behaves_like "returns 401 unauthenticated with error message"
    end

    context "when current user is not an admin", :aggregate_failures do
      let(:current_user) { create(:user) }

      before { current_user }

      it_behaves_like "returns 403 unauthorized with error message"
    end
  end
end
