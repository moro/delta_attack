require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'delta_attack/extractor/excel'
require 'java'
require 'timeout'

describe DeltaAttack::Extractor::Excel do
  include SpecHelper
  before do
    @is = Java::JavaIo::ByteArrayInputStream.new(
      File.read(sample_data("13TOKYO.xls")).to_java_bytes)

    @xls = DeltaAttack::Extractor::Excel.new(@is)
  end

  it { @xls.input_stream.should_not be_nil }
  it "data[0][0].should == 13101" do
    @xls.data[0][0][0].should == 13101
  end

  it "2nd call of data() should be cached" do
    @xls.data # 1st.
    lambda{ timeout(0.1){ @xls.data } }.should_not raise_error(Timeout::Error)
  end
end

