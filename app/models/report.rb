class Report < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"

  enum content: { user:0, post:1, post_comment:2 }
  enum reason: { spam:0, pornography:1, malicious:2, terrorism:3, harassment:4, harm:5, misinformation:6 }
end
