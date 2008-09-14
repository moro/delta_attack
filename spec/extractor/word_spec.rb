require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'delta_attack/extractor/word'
require 'java'
require 'timeout'
$KCODE = "u"

describe DeltaAttack::Extractor::Word do
  include SpecHelper
  before do
    content = File.read(sample_data("myblog.doc"))
    @doc = DeltaAttack::Extractor::Word.new(content.to_java_bytes)
  end

  it { @doc.bytes.should_not be_nil }
  it "data.flatten.first.should =~ /WEBrick/" do
    @doc.data.flatten.first.should =~ /WEBrick/
  end

  it "2nd call of data() should be cached" do
    @doc.data # 1st.
    lambda{ timeout(0.1){ @doc.data } }.should_not raise_error(Timeout::Error)
  end
end

