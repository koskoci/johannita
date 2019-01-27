require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:params) { { title: "foo", content: "bar", thumbnail_url: "foo.bar.com", blurb: "This is the blurb" } }

  it "is valid with valid the params" do
    user = Post.new(params)
    expect(user).to be_valid
    expect(user.title).to eq "foo"
    expect(user.content).to eq "bar"
    expect(user.thumbnail_url).to eq "foo.bar.com"
    expect(user.blurb).to eq "This is the blurb"
  end
end
