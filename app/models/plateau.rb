class Plateau < ApplicationRecord
	has_many :rovers

	validates :size, presence: true, format: { with: /\A\d+\z/, message: "Integer only. No sign allowed." }

	before_create :set_limits

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
			fomat_line = line.strip
			arr.push(fomat_line) unless fomat_line.blank?
		end
		f.close
		arr
	end

	private

	#considers only the first two digits
	def set_limits
		size.split('').each_with_index do |limit, index|
			if index.eql?(0)
				self.limit_x = limit.to_i
			elsif index.eql?(1)
				self.limit_y = limit.to_i
			end
		end
	end
end
