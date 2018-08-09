class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'
  attribute :email
  attribute :password_digest
  attribute :admin
  attribute :created_at
  attribute :updated_at
  attribute :first_name
  attribute :last_name
end
