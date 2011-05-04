# 
# See README for details of collagecomposer
# 
# Zahan Malkani <zahanm at gmail.com>
# 

require 'RMagick'

include Magick

class Segmenter
	
	attr_accessor :num_rows, :num_cols, :pixels_box, :target

	def initialize(target, num_rows)
		@target = Image.read(target)[0]
		@num_rows = num_rows
    @pixels_box = (@target.rows / num_rows).to_i
    @num_cols = (@target.columns / @pixels_box).to_i
	end

	def segment()
    unless block_given?
      raise ArgumentError, "Need a block"
    end
    for row in 0..@num_rows
      for col in 0..@num_cols
        x = @pixels_box * row
        y = @pixels_box * col
        yield @target.crop(x,y,@pixels_box,@pixels_box,true), row, col
      end
    end
	end

end


