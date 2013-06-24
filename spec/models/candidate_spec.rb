require 'spec_helper'
require 'nokogiri'
require 'open-uri'

describe Candidate do
  before(:each) do
    @name = [*('a'..'z')].sample(5).join
    @age = [*('0'..'9')].sample(2).join
    @gender = ['M','F'].sample(1).join
    @candidate = Candidate.new({:name => @name, :age => @age, :gender => @gender })
    @uuid = @candidate.save["uuid"]
  end

  it "should get uuid after create candidate" do
    @uuid.should match "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}"
  end

  it "should raise error from abctech's API if uuid is not given" do
    Candidate.load(nil).should raise_error
  end

  it "should get name from abctech's API if uuid is given" do
    Candidate.load(@uuid)["name"].should == @name
  end

  it "should get age from abctech's API if uuid is given" do
    Candidate.load(@uuid)["age"].should == @age.to_i
  end

  it "should get gender from abctech's API if uuid is given" do
    Candidate.load(@uuid)["gender"].should == @gender
  end

  it "should get no error after uploading new photo" do
    Candidate.upload_picture(:uuid => @uuid)["errorMessage"].should be_nil
  end

  it "should get new image after uploading photo" do
    Candidate.upload_picture(:uuid => @uuid)
    Nokogiri::HTML(open("http://siam.dev.abctech-thailand.com/candidate/view.html?uuid=#{@uuid}")).css("img")[0]["src"].should match "#{@uuid}.png"

  end

end
