class AddPasswordDigestToCoach < ActiveRecord::Migration[6.1]
  add_column :coaches, :password_digest, :string
end
