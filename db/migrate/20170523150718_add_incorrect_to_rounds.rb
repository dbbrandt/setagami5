class AddIncorrectToRounds < ActiveRecord::Migration[5.1]
  def change
    add_column :rounds, :incorrect, :text
  end
end
