class AddContentIdToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :content_id, :integer
  end
end
