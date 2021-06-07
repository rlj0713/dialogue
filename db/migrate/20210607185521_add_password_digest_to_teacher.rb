class AddPasswordDigestToTeacher < ActiveRecord::Migration[6.1]
  add_column :teachers, :password_digest, :string
end
