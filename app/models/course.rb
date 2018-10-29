# == Schema Information
#
# Table name: courses
#
#  id                 :bigint(8)        not null, primary key
#  apply_by           :date             not null
#  max_participants   :integer          default(20)
#  status             :string           default("posted"), not null
#  title              :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  course_category_id :bigint(8)        not null
#
# Indexes
#
#  index_courses_on_course_category_id  (course_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_category_id => course_categories.id)
#

class Course < ApplicationRecord
  has_many :course_events
  has_many :participants
  has_many :users, through: :participants
  belongs_to :course_category, optional: true
  validates :apply_by, presence: true

  VALID_STATUSES = %w[posted cancelled confirmed]
  ACTIVE_STATUSES = VALID_STATUSES.reject { |e| e == "cancelled" }

  def can_apply(user)
    return unless user
    Courses::CanApply.new(user, self).call
  end
end
