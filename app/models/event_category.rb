# == Schema Information
#
# Table name: event_categories
#
#  id         :bigint(8)        not null, primary key
#  category   :string
#  last_date  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class EventCategory < ApplicationRecord
end
