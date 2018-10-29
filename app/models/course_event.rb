# == Schema Information
#
# Table name: course_events
#
#  id         :bigint(8)        not null, primary key
#  date       :date
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint(8)        not null
#
# Indexes
#
#  index_course_events_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#

class CourseEvent < ApplicationRecord
  belongs_to :course, optional: true
  has_many :participants, through: :course
end
