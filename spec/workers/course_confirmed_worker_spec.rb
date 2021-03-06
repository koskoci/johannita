require "rails_helper"

RSpec.describe CourseConfirmedWorker do
  let(:user_1) { create :user }
  let(:user_2) { create :user }
  let(:course) { create :course }
  let(:participant_1) { create :participant, course: course, user: user_1 }
  let(:participant_2) { create :participant, course: course, user: user_2 }
  let(:mailer) { instance_double(CourseConfirmedMailer, call: OpenStruct.new(deliver_now: true)) }

  before do
    participant_1
    participant_2
  end

  describe '.perform_async' do
    it "enqueues a job" do
      expect { CourseConfirmedWorker.perform_async(course.id) }
        .to change(CourseConfirmedWorker.jobs, :size).by(1)
    end

    it "calls the right service" do
      allow(CourseConfirmedMailer)
        .to receive(:with).with(user: user_1, event: course)
        .and_return(mailer)
      allow(CourseConfirmedMailer)
        .to receive(:with).with(user: user_2, event: course)
        .and_return(mailer)
      expect(mailer).to receive(:call).twice

      CourseConfirmedWorker.perform_async(course.id)
      CourseConfirmedWorker.drain
    end
  end
end
