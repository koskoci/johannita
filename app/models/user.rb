class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :pav_until_before_type_cast, date: true
  validates :driving_licence_since_before_type_cast, date: true
  has_one_attached :curriculum_vitae
end
