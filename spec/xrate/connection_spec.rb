require "spec_helper"

describe Xrate::Connection do

  before do
    @obj = Object.new
    @obj.extend Xrate::Connection
  end

  describe "#url" do

    it "should respond to url" do
      @obj.url.should == "https://xrate.gocoin.com"
    end

    it "should be able to change url" do
      @obj.url = "https://gocoin.com"
      @obj.url.should == "https://gocoin.com"
    end

  end

  describe "#connection" do

    it "should create and cache a faraday connection" do
      conn = double(:connection)
      Faraday.should_receive(:new).with(url: "#{@obj.url}/v#{@obj.api_version}").and_return(conn)
      @obj.connection.should == conn
      Faraday.should_not_receive(:new).with(@obj.url)
      @obj.connection
    end

  end

end
