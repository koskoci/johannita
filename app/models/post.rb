# == Schema Information
#
# Table name: posts
#
#  id            :bigint(8)        not null, primary key
#  content       :text
#  thumbnail_url :string           not null
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Post < ApplicationRecord
  has_many_attached :images
end
