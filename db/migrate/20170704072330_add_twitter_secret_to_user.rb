class AddTwitterSecretToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :twitter_secret, :text
  end
end
