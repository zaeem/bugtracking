class CreateProject < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_name
      t.integer :user_id
    end
  end
end
