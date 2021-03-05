class Movement < ApplicationRecord
  belongs_to :rover

  validates :x, :y, :orientation, presence: true
end
