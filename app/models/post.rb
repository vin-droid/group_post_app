class Post < ApplicationRecord
  belongs_to :user, inverse_of: :posts
  belongs_to :group, inverse_of: :posts
  has_many   :comments ,dependent: :destroy
  mount_uploader :image, AvatarUploader

  validates :title , presence: true

end
