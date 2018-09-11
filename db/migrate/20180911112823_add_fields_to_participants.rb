class AddFieldsToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :attended, :boolean
    add_column :participants, :passed, :boolean
  end
end
