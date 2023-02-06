class GroupUser < ApplicationRecord
    belongs_to :user
    belongs_to :group
    has_one_attached :profile_image
end
