module CourseCategories
  class UpdateLastDate
    def initialize(course_category)
      @course_category = course_category
    end

    def call
      course_category.update(last_date: last_date) if last_date
    end

    private

    attr_reader :course_category

    def last_date
      @_last_date ||= course_category
        .course_events
        .where(status: CourseEvent::ACTIVE_STATUSES)
        .order(:date)
        .last
        &.date
    end
  end
end