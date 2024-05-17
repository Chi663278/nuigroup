class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  scope :only_active, -> { where(is_active: true) }
  
  validates :comment, presence: true, length: { maximum: 500 }  
end
