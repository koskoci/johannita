# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  apply_by   :date
#  category   :string
#  date       :date
#  status     :string           default("posted")
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
end
