class AddCascadeDelete < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key :participants, :course_events
    add_foreign_key :participants, :course_events, on_delete: :cascade
  end

  def down
    remove_foreign_key :participants, :course_events
    add_foreign_key :participants, :course_events
  end
end
