require "rails_helper"

RSpec.describe CourseEvents::CanApply do
  subject { described_class.new(user, course_event) }

  let(:user) { create :user, id: 1 }
  let(:course_event) { create :course_event, course_category: course_category }

  before { course_event }

  describe 'call' do
    context "if course_event belongs to a course_category without a prerequisite" do
      let(:course_category) { create :course_category, prerequisite_course_category_id: nil }

      it "returns true" do
        expect(subject.call).to eq true
      end
    end

    context "if course_event belongs to a course_category with a prerequisite" do
      let(:course_category) { create :course_category, id: 1, prerequisite_course_category_id: 2 }
      let(:prerequisite) { create :course_category, id: 2 }
      let(:prerequisite_course_event) { create :course_event, course_category: prerequisite }

      context "the user has applied to but not yet attended the prerequisite course" do
        before { create :participant, course_event: prerequisite_course_event, attended: nil, passed: nil }

        it "returns false" do
          expect(subject.call).to eq false
        end
      end

      context "the user has attended but not yet passed the prerequisite course" do
        before { create :participant, course_event: prerequisite_course_event, attended: true, passed: nil }

        it "returns false" do
          expect(subject.call).to eq false
        end
      end

      context "the user has passed the prerequisite course" do
        before { create :participant, course_event: prerequisite_course_event, passed: true }

        it "returns true" do
          expect(subject.call).to eq true
        end
      end

      context "the user has passed some other course" do
        let(:another_course_event) { create :course_event, course_category: another_course_category }
        let(:another_course_category) { create :course_category }

        before { create :participant, course_event: another_course_event, passed: true }

        it "returns false" do
          expect(subject.call).to eq false
        end
      end
    end
  end
end
