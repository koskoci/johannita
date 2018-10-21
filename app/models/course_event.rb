# == Schema Information
#
# Table name: course_events
#
#  id                 :bigint(8)        not null, primary key
#  apply_by           :date
#  date               :date
#  status             :string           default("posted")
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  course_category_id :bigint(8)
#
# Indexes
#
#  index_course_events_on_course_category_id  (course_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_category_id => course_categories.id)
#

class CourseEvent < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
  belongs_to :course_category
  validates :apply_by, presence: true

  VALID_STATUSES = %w[posted cancelled confirmed]
  ACTIVE_STATUSES = VALID_STATUSES.reject { |e| e == "cancelled" }

  def can_apply(user)
    return unless user
    CourseEvents::CanApply.new(user, self).call
  end
end
