class AddRememberDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remember_digest, :string
    add_column :users, :admin, :boolean, default: false
  end
end
