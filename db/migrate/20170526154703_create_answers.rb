class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :answer
      t.string :correct_answer
      t.float :score
      t.boolean :correct
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
