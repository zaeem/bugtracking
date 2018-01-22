class AddNameUserTypeToUsers < ActiveRecord::Migration
  def change

    add_column :users, :name, :string
    add_column :users, :user_type, :string

  end
end
