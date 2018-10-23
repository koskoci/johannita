class RenameEventsToCourseEvents < ActiveRecord::Migration[5.2]
  def change
    rename_table :events, :course_events
    rename_column :participants, :event_id, :course_event_id
  end
end
