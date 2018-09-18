class EventConfirmedWorker
  include Sidekiq::Worker

  def perform(course_event_id)
    course_event = course_event(course_event_id)

    course_event.users.each do |user|
      EventConfirmedMailer.with(user: user, event: course_event).call.deliver_now
    end
  end

  private

  def course_event(course_event_id)
    CourseEvent.includes(participants: :user).find(course_event_id)
  end
end
