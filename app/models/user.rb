class User < ApplicationRecord
	has_secure_password
	has_many :users_groups, class_name: "UsersGroup", dependent: :destroy
	has_many :groups, through: :users_groups, dependent: :destroy
	has_many :group_invitations, -> { where status: 'pending'}, class_name: 'UsersGroup',inverse_of: :user, dependent: :destroy
	has_many :posts, dependent: :destroy, inverse_of: :user
	has_many :comments, dependent: :destroy, inverse_of: :user
	before_destroy :transfer_groups_ownership

	before_save { self.email = email.downcase }
	validates :username, presence: true, length:{ minimum: 6 }, :uniqueness => {message:"username already has been taken"}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false ,message:"email already has been taken" }
	validates :password, presence: true, confirmation: true,  length: { minimum: 6 } 
	def owned_groups
		Group.where(group_creator: self.username)
	end

	def is_group_creator_of group
		(self.username == group.group_creator)? true : false
	end

	private
	def transfer_groups_ownership
		@owned_groups = self.owned_groups 
		if @owned_groups.present?
			@owned_groups.each do |group|
				group.update_attribute(:group_creator , group.second_owner.username)
			end
		end
	end
end
