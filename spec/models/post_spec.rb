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
    let(:user) { Post.create(params) }
    let(:file_hash) do
      {
        io: File.open(Rails.root.join('spec', 'fixtures', 'pdf.pdf')),
        filename: 'pdf.pdf',
        content_type: 'application/pdf'
      }
    end

    before { user.images.attach(file_hash) }

    it "has an attached image" do
      images = user.images
      expect(images).to be_an_instance_of(ActiveStorage::Attached::Many)
      expect(images.attached?).to be true
      expect(images.count).to eq 1
      expect(images.first.filename).to eq "pdf.pdf"
    end
  end
end
