class AddMaxParticipantsToCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :courses, :max_participants, :integer, null: :false, default: 20
  end
end
