class User < ApplicationRecord
  devise :registerable,
         :recoverable, :rememberable, :validatable,
         :database_authenticatable
    
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :page_colors
  has_one_attached :image

  # フォローしている人
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow

  # フォロワー
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships ,source: :user

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :screen_name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\p{Punct}]+\z/ }, length: { maximum: 10}
  validates :bio, length: { maximum: 500 }
  
  def following?(another_user)
    self.followings.include?(another_user)
  end

  def follow(another_user)
    unless self == another_user      
      self.relationships.find_or_create_by(follow_id: another_user.id)
    end
  end

  def unfollow(another_user)
    unless self == another_user
      relationship = self.relationships.find_by(follow_id: another_user.id)
      relationship.destroy if relationship
    end
  end
end
