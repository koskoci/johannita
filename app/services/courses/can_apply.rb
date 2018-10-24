module Courses
  class CanApply
    def initialize(user, course)
      @user = user
      @course = course
    end

    def call
      return false if after_apply_by
      return true unless prereq_id
      passed?(user, prereq_id)
    end

    private

    attr_reader :user, :course

    def prereq_id
      @_prereq_id ||= course.course_category.prerequisite_course_category_id
    end

    def passed?(user, prereq_id)
      Participant.where(course_id: courses, passed: true).present?
    end

    def courses
      Course.where(course_category_id: prereq_id)
    end

    def after_apply_by
      Date.today > course.apply_by
    end
  end
end
