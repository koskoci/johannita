# == Schema Information
#
# Table name: participants
#
#  id              :bigint(8)        not null, primary key
#  attended        :boolean
#  passed          :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  course_event_id :bigint(8)        not null
#  user_id         :bigint(8)        not null
#
# Indexes
#
#  index_participants_on_course_event_id              (course_event_id)
#  index_participants_on_course_event_id_and_user_id  (course_event_id,user_id) UNIQUE
#  index_participants_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_event_id => course_events.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id)
#

class Participant < ApplicationRecord
  belongs_to :course_event
  belongs_to :user
end
