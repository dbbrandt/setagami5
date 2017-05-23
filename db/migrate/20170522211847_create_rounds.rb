class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.string :name
      t.integer :correct
      t.integer :answered
      t.integer :total
      t.text :quiz

      t.timestamps
    end
  end
end
