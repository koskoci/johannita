# == Schema Information
#
# Table name: pages
#
#  id      :bigint(8)        not null, primary key
#  content :text
#  slug    :string
#
# Indexes
#
#  index_pages_on_slug  (slug) UNIQUE
#

class Page < ApplicationRecord
  validates :slug, presence: true, uniqueness: true
  validates :content, presence: true
end
