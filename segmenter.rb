
# 
# See README for details of collagecomposer
# 
# Zahan Malkani <zahanm at gmail.com>
# 

class Segmenter
	
	attr_accessor :image

	def initialize(options)
		@image = 'hello world out there'
	end

end

require 'RMagick'

include Magick

cat = ImageList.new('Cheetah.jpg')
cat.display

exit

