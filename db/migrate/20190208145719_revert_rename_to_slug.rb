class RevertRenameToSlug < ActiveRecord::Migration[5.2]
  def change
    rename_column :pages, :slug, :short_name
  end
end
