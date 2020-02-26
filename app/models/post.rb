# Post Model
class Post < ApplicationRecord
  include Discard::Model
  belongs_to :user
  has_rich_text :body

  validates :title, presence: true
  validates :body, presence: true
end
