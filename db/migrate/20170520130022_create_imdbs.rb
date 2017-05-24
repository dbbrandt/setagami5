class CreateImdbs < ActiveRecord::Migration[5.1]
  def change
    create_table :imdbs do |t|
      t.string :title
      t.integer :imdb_id
      t.string :category

      t.timestamps
    end
  end
end
