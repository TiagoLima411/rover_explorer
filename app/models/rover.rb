class Rover < ApplicationRecord
	belongs_to :plateau
	has_many :movements

	validates :comand, :position, presence: true

	after_create :comand_move

	def comand_move
		@route = []
		current_position = get_position
		@route.push(current_position)

		comand.split('').each do |move|
			last_position = @route[@route.size - 1]
			previous_position = @route[@route.size - 2]

			if ['R', 'L'].include?(move)

				new_position = set_position(nil, nil, nil)
				orientation = orientations
				key = (last_position[:orientation] + move).to_sym 
				new_position.orientation = orientation[key]
				new_position.x = last_position.x
				new_position.y = last_position.y
				
				@route.push(new_position)
				
			elsif move.eql?('M')

				last_position = set_position(last_position.x, last_position.y, last_position.orientation)
				
				run = forward(last_position.x, last_position.y)

				x = run[last_position.orientation.to_sym][:mov_x].present? ? run[last_position.orientation.to_sym][:mov_x] : previous_position.x
				y = run[last_position.orientation.to_sym][:mov_y].present? ? run[last_position.orientation.to_sym][:mov_y] : previous_position.y

				last_position.x = x
				last_position.y = y
				@route.push(last_position)

			end

		end

		@route.each do |movement|
			limit_x = (movement.x <= movement.rover.plateau.limit_x) && (movement.x >= 0)
			limit_y = (movement.y <= movement.rover.plateau.limit_y) && (movement.y >= 0)
			movement.save if limit_x && limit_y
		end
	end

	# takes the first position in the defined area
	def get_position

		coordinate = set_position(nil, nil, nil)
		axis = plateau.build_axis

		position.split('').each_with_index do |pos, index|
			coordinate.x = axis[:x][pos.to_i] if index.eql?(0)
			coordinate.y = axis[:y][pos.to_i] if index.eql?(1)
			coordinate.orientation = pos if index.eql?(2)
		end
		coordinate
	end

	private
	
	# Create a movement instance
	def set_position(x = nil, y = nil, orientation = nil)
		Movement.new(rover: self, x: x, y: y, orientation: orientation)
	end

	# Rover orientation
	def orientations
		{
			'NL': 'W',
			'NR': 'E',
			'WL': 'S',
			'WR': 'N',
			'SL': 'E',
			'SR': 'W',
			'EL': 'N',
			'ER': 'S'
		}
	end

	# Rover drive
	def forward(x = 0, y = 0)
		{
			'W': { 'mov_x': x - 1 },
			'E': { 'mov_x': x + 1 },
			'S': { 'mov_y': y - 1 },
			'N': { 'mov_y': y + 1 }
		}
	end

end
