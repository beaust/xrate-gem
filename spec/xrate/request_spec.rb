require "spec_helper"

describe Xrate::Request do

  let(:conn) { double(:connection) }

  describe "#initialize" do

    it "should validate configuration at initialization" do
      expect { Xrate::Request.new(conn, nil) }.to raise_error(Xrate::Error)
    end

    it "should validate configuration at initialization" do
      config = Xrate::Config.new
      expect { Xrate::Request.new(conn, config) }.to raise_error(Xrate::Error)
    end

  end

  describe "#get" do

    before do
      @conn = Faraday.new do |req|
        req.adapter :test do |stub|
          stub.get('/echo') do |env|
            posted_as = env[:request_headers]['Content-Type']
            [200, {'Content-Type' => posted_as}, env[:body]]
          end
        end
      end

      @config = Xrate::Config.new
      @config.username = "username"
      @config.password = "password"
    end

  end
end
