require "spec_helper"
require "jani/strip_maker/movie"
require "jani/strip_maker/transcode_options"

describe Jani::StripMaker::Movie do
  let(:transcode_options) do
    Jani::StripMaker::TranscodeOptions.new.tap do |options|
      options.fps = 15
      options.width = 320
      options.height = 180
    end
  end

  let(:movie) { Jani::StripMaker::Movie.new(movie_filepath: "spec/fixtures/movies/kuro.mov", transcode_options: transcode_options) }

  describe "#to_frame_list" do
    it "retunrs FrameList" do
      transcoded = movie.to_frame_list
      expect(transcoded).to be_a_kind_of(Jani::StripMaker::FrameList)
      expect(transcoded).not_to be_empty
    end
  end
end
