class AddPostToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :post, :text
  end
end
