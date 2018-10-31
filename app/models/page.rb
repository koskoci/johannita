# == Schema Information
#
# Table name: pages
#
#  id         :bigint(8)        not null, primary key
#  content    :text
#  short_name :string
#
# Indexes
#
#  index_pages_on_short_name  (short_name) UNIQUE
#

class Page < ApplicationRecord
  validates :short_name, presence: true, uniqueness: true
  validates :content, presence: true
end
