class User < ApplicationRecord
  devise :registerable,
         :recoverable, :rememberable, :validatable,
         :database_authenticatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :page_colors
  has_one_attached :image

  # フォローしている人
  has_many :following_relationships, foreign_key: :following_id, class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following, dependent: :destroy

  # フォロワー
  has_many :follower_relationships, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships ,source: :follower, dependent: :destroy

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

  def get_user_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'noimage.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
