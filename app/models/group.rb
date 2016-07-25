class Group < ApplicationRecord
    has_many :users_groups, class_name: "UsersGroup"
    has_many :users, through: :users_groups, dependent: :destroy
	has_many :posts, dependent: :destroy, inverse_of: :group
	has_many :accepted_users_groups, ->{where status: 'accepted'}, class_name: "UsersGroup"

	def invite_user user
		User.find(user).users_groups.create! user_id: user, group_id: self.id    #if current_user.is_group_creator_of self 
	end

	def remove_user user
         UsersGroup.where(group_id: self.id, user_id: user).destroy_all   #if current_user.is_group_creator_of self 
	end

	def second_owner
		User.find(self.users_groups.first(2).last.user_id)
	end

	def group_members_other_than admin
		user_ids = self.accepted_users_groups.pluck(:user_id) - Array(admin)
		User.where(id: user_ids)
	end
	def users_not_in_group
	    user_ids = self.users_groups.pluck(:user_id) 
		User.where("id NOT IN (?) ",user_ids)
	end

end
