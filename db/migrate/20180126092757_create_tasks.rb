class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.string :type
      t.string :status
      t.references :creator, index: true, foreign_key: true
      t.references :resolver, index: true, foreign_key: true
    end
  end
end
