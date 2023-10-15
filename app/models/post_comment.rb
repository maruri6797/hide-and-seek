class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  has_many :actions, dependent: :destroy
  has_many :reports, as: :target

  validates :comment, presence: true, length: { maximum: 140 }
end
