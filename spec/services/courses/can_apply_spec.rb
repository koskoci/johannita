require "rails_helper"

RSpec.describe Courses::CanApply do
  subject { described_class.new(user, course) }

  let(:user) { create :user, id: 1 }
  let(:course) { create :course, course_category: course_category, apply_by: Date.today + 7 }

  before { course }

  describe "call" do
    context "if there are no more seats left" do
      let(:course) { create :course, apply_by: Date.today + 7, max_participants: 2 }

      before do
        create :participant, course_id: course.id
        create :participant, course_id: course.id
      end

      it "returns false" do
        expect(subject.call).to eq false
      end
    end

    context "if the apply_by date has passed" do
      let(:course_category) { create :course_category }

      it "returns false" do
        expect(Timecop.freeze(Date.today + 8) { subject.call }).to eq false
      end
    end

    context "if course belongs to a course_category without a prerequisite" do
      let(:course_category) { create :course_category, prerequisite_course_category_id: nil }

      it "returns true" do
        expect(subject.call).to eq true
      end
    end

    context "if course belongs to a course_category with a prerequisite" do
      let(:course_category) { create :course_category, id: 1, prerequisite_course_category_id: 2 }
      let(:prerequisite) { create :course_category, id: 2 }
      let(:prerequisite_course) { create :course, course_category: prerequisite }

      context "the user has applied to but not yet attended the prerequisite course" do
        before { create :participant, course: prerequisite_course, attended: nil, passed: nil }

        it "returns false" do
          expect(subject.call).to eq false
        end
      end

      context "the user has attended but not yet passed the prerequisite course" do
        before { create :participant, course: prerequisite_course, attended: true, passed: nil }

        it "returns false" do
          expect(subject.call).to eq false
        end
      end

      context "the user has passed the prerequisite course" do
        before { create :participant, course: prerequisite_course, passed: true }

        it "returns true" do
          expect(subject.call).to eq true
        end
      end

      context "the user has passed some other course" do
        let(:another_course) { create :course, course_category: another_course_category }
        let(:another_course_category) { create :course_category }

        before { create :participant, course: another_course, passed: true }

        it "returns false" do
          expect(subject.call).to eq false
        end
      end
    end
  end
end
