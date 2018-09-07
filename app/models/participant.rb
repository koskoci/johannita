# == Schema Information
#
# Table name: participants
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_participants_on_event_id  (event_id)
#  index_participants_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#

class Participant < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
