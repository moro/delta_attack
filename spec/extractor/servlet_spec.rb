require File.expand_path("../spec_helper", File.dirname(__FILE__))
require 'delta_attack/extractor/servlet'

describe DeltaAttack::Extractor::Servlet do
  before do
    @servlet = DeltaAttack::Extractor::Servlet.new("hoge", {})

    file = mock("upload_file")
    file.should_receive(:filename).and_return("foo.xls")
    file.should_receive(:[]).with("content-type").and_return("application/vnd.ms-excel")
    file.should_receive(:to_s).and_return("DATA-DATA")

    @req = mock("request")
    @req.should_receive(:query).and_return("file"=>file)

    @res = Struct.new(:body, :content_type, :status).new
  end

  describe "pass" do
    before do
      DeltaAttack::Extractor.should_receive(:extract).with("DATA-DATA", :excel).and_return("RESPONSE")
      @servlet.do_POST(@req, @res)
    end

    it "@res.body.should == 'RESPONSE'" do
      @res.body.should == 'RESPONSE'
    end

    it "@res.content_type.should == 'text/plain'" do
      @res.body.should == 'RESPONSE'
    end
  end

  describe "fail with unsupported type" do
    before do
      DeltaAttack::Extractor.should_receive(:extract).and_raise(DeltaAttack::Extractor::Error)
    end

    it "do_POST.should raise_error(WEBrick::HTTPStatus::BadRequest)" do
      lambda{ @servlet.do_POST(@req, @res) }.should raise_error(WEBrick::HTTPStatus::BadRequest)
    end
  end

  describe "fail with something" do
    before do
      DeltaAttack::Extractor.should_receive(:extract).and_raise(StandardError)
    end

    it "do_POST.should raise_error(WEBrick::HTTPStatus::BadRequest)" do
      lambda{ @servlet.do_POST(@req, @res) }.should raise_error(WEBrick::HTTPStatus::InternalServerError)
    end
  end
end

