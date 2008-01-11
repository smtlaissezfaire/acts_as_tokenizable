require File.dirname(__FILE__) + "/spec_helper"

describe "A TokenizableModel", :shared => true do
  it "should have the token column" do
    @model.should respond_to(:token)
  end
  
  it "should not have a token when a new one is instantiated" do
    @model.token.should == nil
  end
  
  it "should create a new value when created" do
    @model.save!
    @model.token.should_not be_nil
  end
  
  it "should assign the value randomly, and return an MD5 hash" do
    Kernel.stub!(:rand).and_return 44
    random_string = ""
    16.times { |i| random_string << (Kernel.rand(93)+33) }
    value = Digest::MD5.hexdigest(random_string).to_s[0,16]

    @model.save!
    @model.token.should == value
  end
  
  it "should only return a 16 character long value" do
    @model.save!
    @model.token.size.should == 16
  end
  
  it "should be able to be refound via it's id (exploratory test)" do
    @model.save!
    id = @model.id
    @model.class.find(id).should == @model
  end
  
  it "should still have the token, after it is refound by it's id" do
    @model.save!
    id = @model.id
    @model.class.find(id).token.should_not be_nil
  end
end

describe "A", DefaultTokenizableModel do
  before :each do
    @model = DefaultTokenizableModel.new
  end
  
  it_should_behave_like "A TokenizableModel"

  it "should not update the token after it is re-saved" do
    @model.save!
    token = @model.token.dup
    
    @model.save!
    @model.token.should == token
  end
end

describe "A", TokenizableModelWithUpdateTrue do
  before :each do
    @model = TokenizableModelWithUpdateTrue.new
  end
  
  it_should_behave_like "A TokenizableModel"
  
  it "should update the token after it is resaved" do
    @model.save!
    token = @model.token.dup
    @model.save!
    @model.token.should_not == token
  end
end

describe "A", TokenizableModelWithUpdateFalse do
  before :each do
    @model = TokenizableModelWithUpdateFalse.new
  end
  
  it_should_behave_like "A TokenizableModel"
  
  it "should not update the token after it is re-saved" do
    @model.save!
    token = @model.token.dup
    
    @model.save!
    @model.token.should == token
  end
end
