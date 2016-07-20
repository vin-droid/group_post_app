class AddColumnToUsersGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :users_groups, :status, :string , :default => "pending"
  end
end
