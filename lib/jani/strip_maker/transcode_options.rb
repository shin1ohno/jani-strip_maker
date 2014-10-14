class Jani::StripMaker::TranscodeOptions
  attr_accessor :fps, :width, :height

  def to_ffmpeg_options
    [to_bitrate_option(), to_scale_option(), to_fps_option()].join(" ")
  end

  private

  def to_bitrate_option
    "-b:v 50000k"
  end

  def to_scale_option
    "-vf scale=#{@height}:#{@width}"
  end

  def to_fps_option
    "-r #{@fps}"
  end
end
