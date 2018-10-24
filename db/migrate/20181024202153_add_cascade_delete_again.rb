class AddCascadeDeleteAgain < ActiveRecord::Migration[5.2]
  def up
    remove_foreign_key :participants, :courses
    add_foreign_key :participants, :courses, on_delete: :cascade
  end

  def down
    remove_foreign_key :participants, :courses
    add_foreign_key :participants, :courses
  end
end
