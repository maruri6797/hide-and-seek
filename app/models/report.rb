class Report < ApplicationRecord
  belongs_to :target, polymorphic: true
  belongs_to :reporter, class_name: "User", foreign_key: "reporter_id"
  belongs_to :reported, class_name: "User", foreign_key: "reported_id"

  enum reason: { spam:0, pornography:1, malicious:2, terrorism:3, harassment:4, harm:5, misinformation:6 }
end
