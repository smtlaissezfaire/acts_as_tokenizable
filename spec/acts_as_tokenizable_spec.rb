require File.dirname(__FILE__) + "/spec_helper"

describe "A", TokenizableModel do
  before :each do
    @tokenizable_model = TokenizableModel.new
  end

  it "should have the token column" do
    @tokenizable_model.should respond_to(:token)
  end
  
  it "should not have a token when a new one is instantiated" do
    @tokenizable_model.token.should == nil
  end
  
  it "should create a new value when created" do
    @tokenizable_model.save!
    @tokenizable_model.token.should_not be_nil
  end
  
  it "should assign the value randomly, and return an MD5 hash" do
    Kernel.stub!(:rand).and_return 44
    random_string = ""
    16.times { |i| random_string << (Kernel.rand(93)+33) }
    value = Digest::MD5.hexdigest(random_string).to_s[0,16]

    @tokenizable_model.save!
    @tokenizable_model.token.should == value
  end
  
  it "should only return a 16 character long value" do
    @tokenizable_model.save!
    @tokenizable_model.token.size.should == 16
  end
  
  it "should be able to be refound via it's id (exploratory test)" do
    @tokenizable_model.save!
    id = @tokenizable_model.id
    TokenizableModel.find(id).should == @tokenizable_model
  end
  
  it "should still have the token, after it is refound by it's id" do
    @tokenizable_model.save!
    id = @tokenizable_model.id
    TokenizableModel.find(id).token.should_not be_nil
  end  
end
