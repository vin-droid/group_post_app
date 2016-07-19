class Post < ApplicationRecord
  
  belongs_to :user
  belongs_to :group
  mount_uploader :image, AvatarUploader
end
