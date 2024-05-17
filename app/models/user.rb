class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :page_colors

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :screen_name, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9\p{Punct}]+\z/ }, length: { maximum: 10}
  validates :bio, length: { maximum: 500 }
end
