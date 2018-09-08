# == Schema Information
#
# Table name: events
#
#  id                :bigint(8)        not null, primary key
#  apply_by          :date
#  date              :date
#  status            :string           default("posted")
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  event_category_id :bigint(8)
#
# Indexes
#
#  index_events_on_event_category_id  (event_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_category_id => event_categories.id)
#

class Event < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
  belongs_to :event_category
end
