class Group < ApplicationRecord
    has_many :users_groups, class_name: "UsersGroup", dependent: :destroy
    has_many :users, through: :users_groups, dependent: :destroy
	has_many :posts, dependent: :destroy, inverse_of: :group

	def invite_user user
		UsersGroup.create! user_id: user_id, group_id: self.id    if current_user.is_group_creator_of self 
	end

	def remove_user user
         User.find(user).groups.where(group_id: self.id).destroy_all   if current_user.is_group_creator_of self 
	end

	def second_owner
		User.find(self.users_groups.first(2).last.user_id)
	end
end
