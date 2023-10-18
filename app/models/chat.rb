class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :message, presence: true, length: { maximum: 200 }
end
