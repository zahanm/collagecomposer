# 
# See README for details of collagecomposer
#
# Zahan Malkani <zahanm at gmail.com>
#

require 'RMagick'
require 'segmenter'

include Magick

unless ARGV.length != 0
  puts "Usage: ruby composer.rb <mosaic_target> <num_rows> <base_images...> "
  exit
end
target = ARGV[0] # mosaic target image
num_rows = ARGV[1] # num rows on collage
image_names = ARGV[2-ARGV.length] # other images

segmenter = Segmenter.new target, num_rows
images = ImageList.new(*image_names) # unpacking array
segmenter.segment()

