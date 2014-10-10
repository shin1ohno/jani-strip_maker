require "jani/strip_maker"
require "jani/strip_maker/strip"
require "RMagick"

class Jani::StripMaker::FrameList
  include Magick

  attr_reader :images

  def initialize(images: [])
    @images = images.dup
  end

  def append_image(image)
    @images << image
  end

  def append_image_with_filename(filename)
    append_image(Image.read(filename)[0])
  end

  def to_strips
    [].tap do |strips|
      index = 1
      while !@images.empty?
        strip = Jani::StripMaker::Strip.new(index: index)
        until @images.empty? || strip.big_enough?
          strip.append_frame(@images.shift)
        end
        strips << strip
        index = index + 1
        next
      end
    end
  end
end
