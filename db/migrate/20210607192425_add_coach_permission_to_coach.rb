class AddCoachPermissionToCoach < ActiveRecord::Migration[6.1]
  add_column :coaches, :coach_permission, :boolean
end
