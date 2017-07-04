class AddTwittertokenToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :twitter_token, :text
  end
end
