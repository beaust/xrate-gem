require "spec_helper"

describe Xrate do

  describe "#enable_faraday_logger" do

    it "should insert faraday logging middleware" do
      Xrate.instance_variable_set("@connection", nil)
      conn = double(:connection)
      Faraday.should_receive(:new).with(url: "#{Xrate.url}/v#{Xrate.api_version}").and_return(conn)
      conn.should_receive(:response).with(:logger)
      Xrate.enable_faraday_logger
    end

  end

  describe "should be configurable" do

    it do
      Xrate.config.url = "http://test.com"
      Xrate.config.url.should == "http://test.com"
      Xrate.config.username = "new_username"
      Xrate.config.username.should == "new_username"
      Xrate.config.password = "new_password"
      Xrate.config.password.should == "new_password"
      Xrate.config.api_version = "new_api_version"
      Xrate.config.api_version.should == "new_api_version"
    end

  end

end
