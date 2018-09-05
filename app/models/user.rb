class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :pav_until_before_type_cast, :driving_licence_since_before_type_cast, date: true
  has_one_attached :curriculum_vitae
  has_one_attached :cover_letter
end
