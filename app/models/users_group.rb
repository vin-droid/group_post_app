class UsersGroup < ApplicationRecord

	belongs_to :user,  inverse_of: :users_groups
	belongs_to :group #, inverse_of: :users_groups
end
