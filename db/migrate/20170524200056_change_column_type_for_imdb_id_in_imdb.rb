class ChangeColumnTypeForImdbIdInImdb < ActiveRecord::Migration[5.1]
  def change
    change_column :imdbs, :imdb_id, :string
  end
end
