class Group < ApplicationRecord

	has_many :users_group
	has_many :users  ,through: :users_group 
	has_many :posts ,dependent: :destroy

	def invite_user user
		UsersGroup.create! user_id: user_id, group_id: self.id    if current_user.is_group_creator_of self 
	end

	def remove_user user
         User.find(user).groups.where(group_id: self.id).destroy_all   if current_user.is_group_creator_of self 
	end
end
