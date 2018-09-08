require 'rails_helper'

RSpec.describe Event, :type => :model do
  let(:params) { { title: "foo", event_category: event_category, date: Date.parse("2000-01-01"), status: "cancelled" } }
  let(:event_category) { create(:event_category) }

  it "is valid with valid the params" do
    user = Event.new(params)
    expect(user).to be_valid
    expect(user.title).to eq "foo"
    expect(user.event_category).to eq event_category
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

  it "belongs to an event category" do
    assc = described_class.reflect_on_association(:event_category)
    expect(assc.macro).to eq :belongs_to
  end

  context "if event category is missing" do
    let(:params) { { title: "foo", date: Date.parse("2000-01-01"), status: "cancelled" } }

    it "is invalid" do
      expect(Event.new(params)).not_to be_valid
    end
  end
end
