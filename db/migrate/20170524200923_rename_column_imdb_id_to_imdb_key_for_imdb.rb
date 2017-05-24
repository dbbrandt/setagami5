class RenameColumnImdbIdToImdbKeyForImdb < ActiveRecord::Migration[5.1]
  def change
    rename_column :imdbs, :imdb_id, :imdb_key
  end
end
