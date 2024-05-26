class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_one_attached :image

  scope :only_active, -> { where(is_active: true) }

  validates :caption, length: { maximum: 500 }
  validates :image, presence: true

end
