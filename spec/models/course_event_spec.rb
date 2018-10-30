require 'rails_helper'

RSpec.describe CourseEvent, type: :model do
  let(:params) { { title: "foo", course: course, date: Date.parse("2000-01-01") } }
  let(:course) { create(:course) }

  subject { CourseEvent.new(params) }

  describe "Associations" do
    it { should belong_to(:course) }
    it { should have_many(:participants) }
  end

  describe "Validations" do
    it "is valid with valid params" do
      expect(subject).to be_valid
      expect(subject.title).to eq "foo"
      expect(subject.course).to eq course
      expect(subject.date).to eq Date.parse("2000-01-01")
    end

    context "if course is missing" do
      let(:params) { { title: "foo", date: Date.parse("2000-01-01") } }

      it "raises" do
        expect { subject.save }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
