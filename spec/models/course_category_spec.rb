require 'rails_helper'

RSpec.describe CourseCategory, :type => :model do
  let(:params) { { last_date: "2018-01-01", category: "Elsosegely-tanfolyam" } }

  it "is valid with valid the params" do
    course_category = CourseCategory.new(params)
    expect(course_category).to be_valid
    expect(course_category.last_date).to eq Date.parse("2018-01-01")
    expect(course_category.category).to eq "Elsosegely-tanfolyam"
  end

  it { should validate_presence_of(:category) }
end
