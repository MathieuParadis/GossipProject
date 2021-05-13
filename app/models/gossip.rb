class Gossip < ApplicationRecord
  belongs_to :user
  has_many :jointablegossiptags
  has_many :tags, through: :jointablegossiptags
  has_many :likes

  validates :title,
    presence: true,
    length: { in: 3..14 }

  validates :content,
    presence: true

end
