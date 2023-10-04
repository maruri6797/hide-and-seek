class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy


  validates :message, length: { maximum: 200 }
end
