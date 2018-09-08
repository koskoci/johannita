require 'rails_helper'

RSpec.describe EventCategory, :type => :model do
  let(:params) { { last_date: "2018-01-01", category: "Elsosegely-tanfolyam" } }

  it "is valid with valid the params" do
    event_category = EventCategory.new(params)
    expect(event_category).to be_valid
    expect(event_category.last_date).to eq Date.parse("2018-01-01")
    expect(event_category.category).to eq "Elsosegely-tanfolyam"
  end
end
