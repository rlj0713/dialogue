class AddPasswordDigesttoUser < ActiveRecord::Migration[6.1]
  add_column :users, :password_digest, :string
end
