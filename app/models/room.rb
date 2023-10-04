class Room < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
