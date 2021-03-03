class Plateau < ApplicationRecord
	has_many :rovers
	
	attr_accessor :axis

	def build_axis
		axis = { x: [], y: [] }
		size.split('').each_with_index do |limit, index|
			if index.eql?(0)
				(0..limit.to_i).each do |x|
					axis[:x].push(x)
				end
			elsif index.eql?(1)
				(0..limit.to_i).each do |y|
					axis[:y].push(y)
				end
			end
		end
		axis
	end

	def file_to_array(file)
		arr = []
		f = file.open
		f.each_line do |line|
			arr.push(line)
		end
		f.close
		arr
	end
end
