class Action < ApplicationRecord
  belongs_to :user
  belongs_to :post_comment
  belongs_to :post
end