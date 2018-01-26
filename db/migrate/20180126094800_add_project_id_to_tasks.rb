class AddProjectIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :project, :reference
  end
end
