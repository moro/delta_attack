require File.expand_path("spec_helper", File.dirname(__FILE__))
require 'delta_attack/filetype_assumption'

describe DeltaAttack::FiletypeAssumption do
  include SpecHelper
  it "should not support_magic" do
    DeltaAttack::FiletypeAssumption.should_not be_support_magic
  end

  describe "new('hoge.xls')" do
    before do
      @asm = DeltaAttack::FiletypeAssumption.new('hoge.xls')
    end

    it "filetype.should == :excel" do
      @asm.filetype.should == :excel
    end
  end

  describe "new('hoge.dat', 'application/vnd.ms-excel')" do
    before do
      @asm = DeltaAttack::FiletypeAssumption.new('hoge.dat', 'application/vnd.ms-excel')
    end

    it "filetype.should == :excel" do
      @asm.filetype.should == :excel
    end
  end

  describe "new('hoge.dat', 'application/octet-stream')" do
    before do
      @asm = DeltaAttack::FiletypeAssumption.new('hoge.dat', 'application/octet-stream')
    end

    it "filetype.should == :unknown" do
      @asm.filetype.should == :unknown
    end
  end

  describe "new('hoge.dat', 'application/octet-stream', <content>)" do
    before do
      content = File.read(sample_data("13TOKYO.xls"))
      @asm = DeltaAttack::FiletypeAssumption.new('hoge.dat', 'application/octet-stream', content)
    end

    it "filetype.should == :excel" do
      pending "mahoro is not installed" unless DeltaAttack::FiletypeAssumption.support_magic?
      @asm.filetype.should == :excel
    end
  end
end
