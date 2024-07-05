class User < ApplicationRecord
  devise :registerable,
         :recoverable, :rememberable, :validatable,
         :database_authenticatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :page_colors
  has_one_attached :image

  scope :only_active, -> { where(is_active: true) }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :screen_name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\p{Punct}]+\z/ }, length: { maximum: 10}
  validates :bio, length: { maximum: 500 }

  def get_user_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'noimage.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


  has_many :relationships, foreign_key: "following_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  def follow(user)
    relationships.create(follower_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(follower_id: user.id).destroy
  end

  def is_followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end
  
  def active_for_authentication?
    super && (is_active == true)
  end
end
