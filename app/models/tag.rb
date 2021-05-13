class Tag < ApplicationRecord
  has_many :jointablegossiptags
  has_many :gossips, through: :jointablegossiptags
end
