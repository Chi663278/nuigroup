class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_one_attached :image

  scope :only_active, -> { where(is_active: true) }

  validates :caption, length: { maximum: 500 }
  validates :image, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  def get_post_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'noimage.png', content_type: 'image/png')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
end
