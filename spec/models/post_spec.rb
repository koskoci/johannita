require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:params) { { title: "foo", content: "bar" } }

  it "is valid with valid the params" do
    user = Post.new(params)
    expect(user).to be_valid
    expect(user.title).to eq "foo"
    expect(user.content).to eq "bar"
  end

  context "when it has images attached" do
    let(:post) { Post.create(params) }
    let(:image_fixture) do
      fixture_file_upload(Rails.root.join('spec', 'fixtures', 'Geranium sanguineum.jpg'), 'image/jpg')
    end

    before { post.images.attach(image_fixture) }

    it "has an attached image" do
      images = post.images
      expect(images).to be_an_instance_of(ActiveStorage::Attached::Many)
      expect(images.attached?).to be true
      expect(images.count).to eq 1
      expect(images.first.filename).to eq "Geranium sanguineum.jpg"
    end
  end
end
