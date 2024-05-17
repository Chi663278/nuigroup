class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_one_attached :image

  scope :only_active, -> { where(is_active: true) }

  validates :caption, length: { maximum: 500 }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
    image
  end
end
