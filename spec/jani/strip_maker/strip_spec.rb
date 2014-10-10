require 'spec_helper'
require 'jani/strip_maker/strip'
include Magick

describe Jani::StripMaker::Strip do
  let(:images_count) { rand(10) + 10 }
  let(:strip) { Jani::StripMaker::Strip.new(images: images) }

  let(:images) do
    [].tap do |images|
      images_count.times { images << Image.new(1,1) }
    end
  end

  describe "#pixels (private)" do
    subject { strip.send(:pixels) }

    it "sums all images pixels up" do
      expect(subject).to eq(images_count * 1 * 1)
    end
  end

  describe "#big_enough?" do
    context "when pixels is below limit" do
      it { expect(strip).not_to be_big_enough }
    end

    context "when pixels equals limit" do
      before { stub_const("Jani::StripMaker::MAX_PIXELS_FOR_MOBILE_SAFARI", images_count + 1) }
      it { expect(strip).not_to be_big_enough }
    end

    context "when pixels is below limit" do
      before { stub_const("Jani::StripMaker::MAX_PIXELS_FOR_MOBILE_SAFARI", images_count) }
      it { expect(strip).to be_big_enough }
    end
  end
end
