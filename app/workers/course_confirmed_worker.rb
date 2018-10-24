class CourseConfirmedWorker
  include Sidekiq::Worker

  def perform(course_id)
    course = course(course_id)

    course.users.each do |user|
      CourseConfirmedMailer.with(user: user, event: course).call.deliver_now
    end
  end

  private

  def course(course_id)
    Course.includes(:users).find(course_id)
  end
end
