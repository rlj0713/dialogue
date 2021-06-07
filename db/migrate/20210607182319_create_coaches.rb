class CreateCoaches < ActiveRecord::Migration[6.1]
  def change
    create_table :coaches do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :uid
      t.string :image

      t.timestamps
    end
  end
end
