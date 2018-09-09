# == Schema Information
#
# Table name: course_categories
#
#  id                              :bigint(8)        not null, primary key
#  category                        :string           not null
#  last_date                       :date
#  title                           :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  prerequisite_course_category_id :integer
#

class CourseCategory < ApplicationRecord
  validates :category, presence: true
end
