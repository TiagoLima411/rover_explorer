class Movement < ApplicationRecord
  belongs_to :rover

  validates :x, :y, :orientation, presence: true

  validate :check_plateau_limit

  def check_plateau_limit
    limit = self.x > self.rover.plateau.limit_x || self.x < 0
    limit = self.y > self.rover.plateau.limit_y || self.y < 0
    
    if limit
      self.errors.add(:base, "Exceeds the plateau limit!" )
    end
	end
end
