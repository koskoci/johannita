# == Schema Information
#
# Table name: participants
#
#  id         :bigint(8)        not null, primary key
#  event_id   :bigint(8)        not null
#  user_id    :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participant < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
