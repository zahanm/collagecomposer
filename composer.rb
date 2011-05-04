# 
# See README for details of collagecomposer
#
# Zahan Malkani <zahanm at gmail.com>
#

require 'RMagick'
require 'segmenter'

include Magick

unless ARGV.length != 0
  puts "\nUsage: ruby composer.rb <mosaic_target> <num_rows> <base_images...>\n"
  exit
end
target_name = ARGV[0] # mosaic target image
num_rows = ARGV[1].to_i # num rows on collage
image_names = ARGV[2-ARGV.length] # other images

segmenter = Segmenter.new target_name, num_rows
sources = ImageList.new(*image_names).each do |img|
  img.resize_to_fill! segmenter.pixels_box
end
target = Image.new(segmenter.target.columns, segmenter.target.rows)
segmenter.segment() do | target_cropped, xoffset, yoffset |
  source = sources[rand(sources.length)]
  mean_red = target_cropped.channel_mean(RedChannel).first
  mean_green = target_cropped.channel_mean(GreenChannel).first
  mean_blue = target_cropped.channel_mean(BlueChannel).first
  pixel = Pixel.new mean_red, mean_green, mean_blue, 0.0
  source = source.colorize 0.70, 0.70, 0.70, pixel
  target.composite! source, xoffset, yoffset, AtopCompositeOp
end
target.write "output.jpg"

