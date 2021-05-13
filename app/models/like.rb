class Like < ApplicationRecord
  belongs_to :user
  belongs_to :gossip

  validates :like,
    presence: true
end
