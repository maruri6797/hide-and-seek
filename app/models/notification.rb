class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :chat, optional: true
  belongs_to :room, optional: true
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id"
  belongs_to :visited, class_name: "User", foreign_key: "visited_id"

  def time_ago_in_words(from_time)
    distance_of_time_in_words(from_time, Time.now)
  end
end
