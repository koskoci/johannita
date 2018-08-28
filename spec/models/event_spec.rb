require 'rails_helper'

RSpec.describe Event, :type => :model do
  let(:params) { { title: "foo", category: "bar", date: Date.parse("2000-01-01"), status: "cancelled" } }

  it "is valid with valid the params" do
    user = Event.new(params)
    expect(user).to be_valid
    expect(user.title).to eq "foo"
    expect(user.category).to eq "bar"
    expect(user.date).to eq Date.parse("2000-01-01")
    expect(user.status).to eq "cancelled"
  end

  it "defaults to status: 'posted'" do
    expect(Event.new.status).to eq "posted"
  end

  it "has many participants" do
    assc = described_class.reflect_on_association(:participants)
    expect(assc.macro).to eq :has_many
  end

  it "has many users" do
    assc = described_class.reflect_on_association(:users)
    expect(assc.macro).to eq :has_many
  end
end
