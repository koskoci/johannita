require "rails_helper"

RSpec.describe EventCancelledWorker do
  let(:user_1) { create :user }
  let(:user_2) { create :user }
  let(:course_event) { create :course_event }
  let(:participant_1) { create :participant, course_event: course_event, user: user_1 }
  let(:participant_2) { create :participant, course_event: course_event, user: user_2 }
  let(:mailer) { instance_double(EventCancelledMailer, call: OpenStruct.new(deliver_now: true)) }

  before do
    participant_1
    participant_2
  end

  describe '.perform_async' do
    it "enqueues a job" do
      expect { EventCancelledWorker.perform_async(course_event.id) }
        .to change(EventCancelledWorker.jobs, :size).by(1)
    end

    it "calls the right service" do
      allow(EventCancelledMailer)
        .to receive(:with).with(user: user_1, event: course_event)
        .and_return(mailer)
      allow(EventCancelledMailer)
        .to receive(:with).with(user: user_2, event: course_event)
        .and_return(mailer)
      expect(mailer).to receive(:call).twice

      EventCancelledWorker.perform_async(course_event.id)
      EventCancelledWorker.drain
    end
  end
end
