class Group < ApplicationRecord
    has_many :group_users
    has_many :users, through: :group_users, source: :user #sourceは書かなくても自動認識する？
    
    validates :name, presence: true
    validates :introduction, presence: true
    has_one_attached :group_image
    
  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end
  
  # ユーザーが既にグループに参加しているかどうかを判断するメソッド
  def inculudesUser?(user)
    group_users.exists?(user_id: user.id)#ここで引数のユーザーidがgroup_usersモデルのuser_idにあるかどうか判断
  end
end
