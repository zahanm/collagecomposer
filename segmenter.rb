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
    @target = Image.read(target).first
    @num_rows = num_rows
    @pixels_box = (@target.rows / num_rows).to_i
    @num_cols = (@target.columns.to_f / @pixels_box).ceil
  end

  def segment()
    unless block_given?
      raise ArgumentError, "Block needed to process segments"
    end
    for row in 0...@num_rows
      for col in 0...@num_cols
        x = @pixels_box * col
        y = @pixels_box * row
        yield @target.crop(x,y,@pixels_box,@pixels_box,true), x, y
      end
    end
  end

end


