module CourseEvents
  class CanApply
    def initialize(user, course_event)
      @user = user
      @course_event = course_event
    end

    def call
      return false if after_apply_by
      return true unless prereq_id
      passed?(user, prereq_id)
    end

    private

    attr_reader :user, :course_event

    def prereq_id
      @_prereq_id ||= course_event.course_category.prerequisite_course_category_id
    end

    def passed?(user, prereq_id)
      Participant.where(course_event_id: course_events, passed: true).present?
    end

    def course_events
      CourseEvent.where(course_category_id: prereq_id)
    end

    def after_apply_by
      Date.today > course_event.apply_by
    end
  end
end