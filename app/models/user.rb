# == Schema Information
#
# Table name: users
#
#  id                    :bigint(8)        not null, primary key
#  email                 :string           not null
#  password_digest       :string           not null
#  admin                 :boolean          default(FALSE)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  first_name            :string           not null
#  last_name             :string           not null
#  pav_until             :date
#  driving_licence_since :date
#

class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :pav_until_before_type_cast, :driving_licence_since_before_type_cast, date: true
  has_one_attached :curriculum_vitae
  has_one_attached :cover_letter
end
