require "tmpdir"
require "jani/strip_maker/frame_list"

class Jani::StripMaker::Movie
  FILE_NAME_PATTERN = "frame%4d"
  FILE_NAME_EXTENTION = "jpg"

  include Magick

  def initialize(movie_filepath: movie_filepath, transcode_options: transcode_options)
    @movie_filepath = (movie_filepath)
    @transcode_options = transcode_options
    @_frame_list = []
  end

  def to_frame_list
    return @_frame_list unless @_frame_list.empty?
    movie_full_path = movie_full_path()
    Dir.mktmpdir do |tmp_dir|
      Dir.chdir(tmp_dir) do |dir|
        execute_ffmpeg_command(movie_full_path)
        images = ImageList.new(*Dir.glob("*\.#{FILE_NAME_EXTENTION}"))
        # TODO: raise error if images is empty
        @_frame_list = Jani::StripMaker::FrameList.new(images: images)
      end
    end
  end

  def to_strips
    to_frame_list().to_strips()
  end

  private

  def execute_ffmpeg_command(movie_full_path)
    if system("ffmpeg -i #{movie_full_path} #{@transcode_options.to_ffmpeg_options} #{FILE_NAME_PATTERN}.#{FILE_NAME_EXTENTION}")
      # OK. Do nothing
    else
      # TODO: raise error
    end
  end

  def movie_full_path
    File.expand_path(@movie_filepath)
  end
end
