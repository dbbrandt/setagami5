class CreatePeople < ActiveRecord::Migration[5.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.references :imdb, foreign_key: true

      t.timestamps
    end
  end
end
