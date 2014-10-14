require "tmpdir"
require "jani/strip_maker/frame_list"

class Jani::StripMaker::Movie
  FILE_NAME_PATTERN = "frame%4d"
  FILE_NAME_EXTENTION = "jpg"

  include Magick

  def initialize(movie_filepath: movie_filepath, transcode_options: transcode_options)
    @movie_filepath = (movie_filepath)
    @transcode_options = transcode_options
  end

  def to_frame_list
    movie_full_path = movie_full_path()
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do |dir|
        execute_ffmpeg_command(movie_full_path)
        images = ImageList.new(*Dir.glob("*\.#{FILE_NAME_EXTENTION}"))
        # TODO: raise error if images is empty
        Jani::StripMaker::FrameList.new(images: images)
      end
    end
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
