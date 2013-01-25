require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '..', 'lib', 'rubygem_api')

describe RubygemApi do

  context "Gem Details" do

    before do
      json = File.read("spec/fixtures/rails.json")
      RestClient.stub(:get).and_return(json)
    end

    it "should get details of the gem" do
      response = RubygemApi.find('rails')
      response['name'].should == 'rails'
    end
  end

  context "Web Hooks" do

    it "should get the registered web hooks" do
      json = File.read("spec/fixtures/web_hooks.json")
      RestClient.stub(:get).and_return(json)
      response = RubygemApi.web_hooks
      response.keys.should match_array(['rails', 'nokogiri'])
    end

    it "should add a new web hook" do
      response = double
      response.stub(:code){ 201 }
      RestClient.stub(:post){ response }
      RubygemApi.add_web_hook('test','localhost').should be_true
    end

  end

end
