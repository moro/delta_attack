require File.expand_path("spec_helper", File.dirname(__FILE__))
require 'delta_attack/extractor'

describe DeltaAttack::Extractor, ".extract" do
  it "(nil, :unknown).should raise_error(DeltaAttack::Extractor::Error)" do
    lambda{
      DeltaAttack::Extractor.extract(nil, :unknown)
    }.should raise_error(DeltaAttack::Extractor::Error)
  end

  describe "(mock, :word)" do
    before do
      @content = mock("content")
      @content.should_receive(:to_java_bytes).and_return(%w(a b c))

      extractor = mock("extractor")
      extractor.should_receive(:data).and_return(%w(a b c))
      DeltaAttack::Extractor::Word.should_receive(:new).with(%w(a b c)).and_return(extractor)
    end

    it 'should == "a\nb\nc"' do
      DeltaAttack::Extractor.extract(@content, :word)
    end
  end
end

