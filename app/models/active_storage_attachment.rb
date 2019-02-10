# == Schema Information
#
# Table name: active_storage_attachments
#
#  id          :bigint(8)        not null, primary key
#  description :string
#  name        :string           not null
#  record_type :string           not null
#  created_at  :datetime         not null
#  blob_id     :bigint(8)        not null
#  record_id   :bigint(8)        not null
#
# Indexes
#
#  index_active_storage_attachments_on_blob_id  (blob_id)
#  index_active_storage_attachments_uniqueness  (record_type,record_id,name,blob_id) UNIQUE
#

class ActiveStorageAttachment < ApplicationRecord
end
