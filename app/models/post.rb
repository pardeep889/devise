class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :image, ImageUploader
  serialize :avatars, JSON
end
