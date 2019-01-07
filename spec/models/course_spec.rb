require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:params) {
    {
      title: "foo", course_category: course_category,
      status: "cancelled", apply_by: Date.parse("1999-01-01")
    }
  }
  let(:course_category) { create(:course_category) }
  let(:user) { create(:user) }

  subject { Course.new(params) }

  describe "Associations" do
    it { should have_many(:course_events) }
    it { should have_many(:participants) }
    it { should have_many(:users) }
    it { should belong_to(:course_category) }
  end

  describe "Validations" do
    it { should validate_presence_of(:apply_by) }

    it "is valid with valid params" do
      expect(subject).to be_valid
      expect(subject.title).to eq "foo"
      expect(subject.course_category).to eq course_category
      expect(subject.apply_by).to eq Date.parse("1999-01-01")
      expect(subject.status).to eq "cancelled"
    end

    it "defaults to status: 'posted'" do
      expect(Course.new.status).to eq "posted"
    end
  end

  it "uses the correct service to calculate can_apply" do
    allow(Courses::CanApply)
      .to receive(:new).with(user, subject)
      .and_call_original

    expect_any_instance_of(Courses::CanApply).to receive(:call).once

    subject.can_apply(user)
  end

  it "returns false if user not logged in" do
    expect(subject.can_apply(nil)).to be false
  end
end
