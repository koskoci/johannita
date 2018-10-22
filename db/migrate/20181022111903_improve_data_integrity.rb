class ImproveDataIntegrity < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    change_column_null :course_events, :apply_by, false
    change_column_null :course_events, :course_category_id, false
    add_index :participants, [:course_event_id, :user_id], unique: true
  end
end
