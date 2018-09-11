require "rails_helper"

RSpec.describe CourseCategories::UpdateLastDate do
  subject { described_class.new(course_category) }

  let(:course_category) { create :course_category, last_date: "2019-01-01" }

  before { course_category }

  describe 'call' do
    context "if there are no course_events" do
      it "does nothing" do
        expect { subject.call }.not_to change { course_category.last_date }
      end
    end

    context "there are course_events with a later date than the current last_date" do
      before do
        create :course_event, date: "2018-01-01", course_category: course_category
        create :course_event, date: "2019-06-01", course_category: course_category
        create :course_event, date: "2019-07-01", course_category: course_category, status: "cancelled"
      end

      it "correctly updates last_date" do
        expect { subject.call }.to change { course_category.last_date }
          .from(Date.parse("2019-01-01")).to(Date.parse("2019-06-01"))
      end
    end
  end
end
