module CourseCategories
  class UpdateLastDate
    def initialize(id)
      @id = id
    end

    def call
      course_category.update(last_date: last_date) if last_date
    end

    private

    attr_reader :course_category, :id

    def last_date
      @_last_date ||= course_category
        .course_events
        .where(status: CourseEvent::ACTIVE_STATUSES)
        .order(:date)
        .last
        &.date
    end

    def course_category
      @_course_category ||= CourseCategory.find(id)
    end
  end
end