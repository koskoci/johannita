class RemoveCounter < ActiveRecord::Migration[5.2]
  def up
    drop_table :counters
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
