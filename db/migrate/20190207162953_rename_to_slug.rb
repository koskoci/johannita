class RenameToSlug < ActiveRecord::Migration[5.2]
  def change
    rename_column :pages, :short_name, :slug
  end
end
