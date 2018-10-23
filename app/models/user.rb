# == Schema Information
#
# Table name: users
#
#  id                    :bigint(8)        not null, primary key
#  admin                 :boolean          default(FALSE)
#  confirm_token         :string
#  driving_licence_since :date
#  email                 :string           not null
#  email_confirmed       :boolean          default(FALSE)
#  first_name            :string           not null
#  last_name             :string           not null
#  password_digest       :string           not null
#  pav_until             :date
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :pav_until_before_type_cast, :driving_licence_since_before_type_cast, date: true
  has_one_attached :curriculum_vitae
  has_one_attached :cover_letter

  def name
    "#{last_name} #{first_name}"
  end
end
