require "RMagick"

class Jani::StripMaker::Strip
  include Magick

  FILE_NAME_DIGITS = 4
  FILE_EXTENTION = "jpg"

  def initialize(images:[] , index: 1)
    @frame_images = images.dup
    @index = index
  end

  def big_enough?
    return false if frames_count.zero?
    pixels / frames_count * (frames_count + 1.0) > Jani::StripMaker::MAX_PIXELS_FOR_MOBILE_SAFARI
  end

  def write(filename = nil)
    name = filename || filename()
    image().write(name)
  end

  def image
    to_rmagic_image_list.append(true)
  end

  def append_frame(frame_image)
    @frame_images << frame_image
  end

  def to_metadata
    {
      index: @index,
      frames_count: frames_count
    }
  end

  private

  def pixels
    image = @frame_images[0]
    return 0 unless image
    image.columns * image.rows * frames_count
    # To be precise, this should be like below,
    # but we can assume all frame has same dimension
    # @frame_images.inject(0) do |pixels, image|
    #   pixels + image.columns * image.rows
    # end
  end

  def frames_count
    @frame_images.count
  end

  def to_rmagic_image_list
    ImageList.new.concat(@frame_images).tap { |list| list.scene = 0 }
  end

  def filename
    "#{@index.to_s.rjust(FILE_NAME_DIGITS, "0")}.#{FILE_EXTENTION}"
  end
end
