require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'delta_attack/extractor/power_point'
require 'java'
require 'timeout'

describe DeltaAttack::Extractor::PowerPoint do
  include SpecHelper
  before do
    content = File.read(sample_data("named_scope06.ppt"))
    @ppt = DeltaAttack::Extractor::PowerPoint.new(content.to_java_bytes)
  end

  it { @ppt.bytes.should_not be_nil }
  it "data.flatten.first.should == /named_scope/" do
    @ppt.data.flatten.first.should =~ /named_scope/
  end

  it "2nd call of data() should be cached" do
    @ppt.data # 1st.
    lambda{ timeout(0.1){ @ppt.data } }.should_not raise_error(Timeout::Error)
  end
end

