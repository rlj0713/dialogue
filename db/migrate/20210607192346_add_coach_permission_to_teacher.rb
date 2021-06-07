class AddCoachPermissionToTeacher < ActiveRecord::Migration[6.1]
  add_column :teachers, :coach_permission, :boolean
end
