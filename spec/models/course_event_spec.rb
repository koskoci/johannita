require 'rails_helper'

RSpec.describe CourseEvent, :type => :model do
  let(:params) { { title: "foo", course_category: course_category, date: Date.parse("2000-01-01"), status: "cancelled", apply_by: Date.parse("1999-01-01") } }
  let(:course_category) { create(:course_category) }
  let(:user) { create(:user) }

  subject { CourseEvent.new(params) }

  it "is valid with valid the params" do
    expect(subject).to be_valid
    expect(subject.title).to eq "foo"
    expect(subject.course_category).to eq course_category
    expect(subject.date).to eq Date.parse("2000-01-01")
    expect(subject.status).to eq "cancelled"
  end

  it "defaults to status: 'posted'" do
    expect(CourseEvent.new.status).to eq "posted"
  end

  it "has many participants" do
    assc = described_class.reflect_on_association(:participants)
    expect(assc.macro).to eq :has_many
  end

  it "has many users" do
    assc = described_class.reflect_on_association(:users)
    expect(assc.macro).to eq :has_many
  end

  it "belongs to an course_event category" do
    assc = described_class.reflect_on_association(:course_category)
    expect(assc.macro).to eq :belongs_to
  end

  it "uses the correct service to calculate can_apply" do
    allow(CourseEvents::CanApply)
      .to receive(:new).with(user, subject)
      .and_call_original

    expect_any_instance_of(CourseEvents::CanApply).to receive(:call).once

    subject.can_apply(user)
  end

  context "if course_event category is missing" do
    let(:params) { { title: "foo", date: Date.parse("2000-01-01"), status: "cancelled" } }

    it "is invalid" do
      expect(subject).not_to be_valid
    end
  end

  it { should validate_presence_of(:apply_by) }
end
