class AddRefToUsersGroup < ActiveRecord::Migration[5.0]
  def change
    add_reference :users_groups, :user, foreign_key: true
    add_reference :users_groups, :group, foreign_key: true
  end
end
