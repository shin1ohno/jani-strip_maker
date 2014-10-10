require 'spec_helper'
require 'jani/strip_maker/frame_list'
include Magick

describe Jani::StripMaker::FrameList do
  let(:images) { [] }
  let(:frame_list) { Jani::StripMaker::FrameList.new(images: images) }

  context "by default" do
    let(:frame_list) { Jani::StripMaker::FrameList.new() }

    it "has no images" do
      expect(frame_list.images).to be_empty
    end
  end

  context "when initialize with images" do
    let(:images) do
      [].tap do |images|
        rand(10).times { images << Image.new(1,1) }
      end
    end

    it "has images" do
      expect(frame_list.images).to eq(images)
      expect(frame_list.images).to have(images.count).items
    end
  end

  describe "#append_image" do
    subject { frame_list.images }
    let(:image) { Image.new(1,1) }

    it "appends image to list" do
      frame_list.append_image(image)
      expect(subject).to eq([image])
    end
  end

  describe "#append_image_with_filename" do
    subject { frame_list.images[0] }
    let(:image_file_name) { "spec/fixtures/images/100x100.jpg" }

    it "appends image to list" do
      frame_list.append_image_with_filename(image_file_name)
      expect(subject).to be_a_kind_of(Image)
      expect(subject.columns).to eq(100)
      expect(subject.rows).to eq(100)
    end
  end

  describe "#to_strips" do
    subject { frame_list.to_strips }
    let(:images) do
      [].tap do |images|
        1000.times { images << Image.new(100,100) }
      end
    end

    it "splits into 4 strips" do
      expect(subject.map(&:to_metadata)).to eq(
        [
          {:index=>1, :frames_count=>314},
          {:index=>2, :frames_count=>314},
          {:index=>3, :frames_count=>314},
          {:index=>4, :frames_count=>58}
        ]
      )
    end
  end
end
