class Post < ApplicationRecord
  validates :text, length: { maximum: 500 }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many_attached :images
end
