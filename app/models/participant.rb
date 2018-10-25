# == Schema Information
#
# Table name: participants
#
#  id         :bigint(8)        not null, primary key
#  attended   :boolean
#  passed     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  idx_course_user_unique           (course_id,user_id) UNIQUE
#  index_participants_on_course_id  (course_id)
#  index_participants_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (user_id => users.id)
#

class Participant < ApplicationRecord
  belongs_to :course
  belongs_to :user
end
