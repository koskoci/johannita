# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  category   :string
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string           default("posted")
#

class Event < ApplicationRecord
  has_many :participants
  has_many :users, through: :participants
end
