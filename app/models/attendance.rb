# == Schema Information
#
# Table name: attendances
#
#  id              :bigint(8)        not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  course_event_id :bigint(8)        not null
#  participant_id  :bigint(8)        not null
#
# Indexes
#
#  index_attendances_on_course_event_id                     (course_event_id)
#  index_attendances_on_course_event_id_and_participant_id  (course_event_id,participant_id) UNIQUE
#  index_attendances_on_participant_id                      (participant_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_event_id => course_events.id)
#  fk_rails_...  (participant_id => participants.id)
#

class Attendance < ApplicationRecord
  belongs_to :course_event
  belongs_to :participant
end
