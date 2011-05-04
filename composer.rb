# 
# See README for details of collagecomposer
#
# Zahan Malkani <zahanm at gmail.com>
#

require 'RMagick'
require 'segmenter'

include Magick

unless ARGV.length != 0
  puts
  puts "Usage: ruby composer.rb <mosaic_target> <num_rows> <base_images...> "
  puts
  exit
end
target = ARGV[0] # mosaic target image
num_rows = ARGV[1].to_i # num rows on collage
image_names = ARGV[2-ARGV.length] # other images

segmenter = Segmenter.new target, num_rows
sources = ImageList.new(*image_names) # unpacking array
target = Image.new(segmenter.target.columns, segmenter.target.rows)
segmenter.segment() do | target_cropped, xoffset, yoffset |
  if row == 5 and col == 5
    target_cropped.display
  end
  target.composite! sources[srand(sources.length)], xoffset, yoffset
  # DEBUG puts "Found somthing"
end

