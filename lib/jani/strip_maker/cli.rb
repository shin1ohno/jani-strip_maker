require "thor"
require "jani/strip_maker/movie"
require "jani/strip_maker/transcode_options"

class Jani::StripMaker::CLI < Thor
  desc "from_movie_to_strips INPUT_FILE", "convert movie file into jani formatted strip images"
  option :fps, type: :numeric, required: true
  option :width, type: :numeric, required: true
  option :height, type: :numeric, required: true
  option :input_file, type: :string, default: true

  def from_movie_to_strips
    transcode_options = Jani::StripMaker::TranscodeOptions.new
    transcode_options.fps = options[:fps]
    transcode_options.width = options[:width]
    transcode_options.height = options[:height]
    movie = Jani::StripMaker::Movie.new(movie_filepath: options[:input_file], transcode_options: transcode_options)
    movie.to_strips.map(&:write)
  end
end
