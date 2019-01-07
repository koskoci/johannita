class AddNotNullToAttendances < ActiveRecord::Migration[5.2]
  def change
    change_column_null :attendances, :course_event_id, false
    change_column_null :attendances, :participant_id, false
    add_index :attendances, [:course_event_id, :participant_id], unique: true
  end
end
