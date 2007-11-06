require File.dirname(__FILE__) + "/spec_helper"

# belongs_to :user
# before_validation_on_create :generate_hash!, :set_date
# validates_associated :user
# validates_presence_of :value, :created_at
# 
# def generate_hash!
#   random_string = String.new
#   16.times { |i| random_string << (Kernel.rand(93)+33) }
#   self.value = Digest::MD5.hexdigest(random_string).to_s[0,16]
# end
# 
# def set_date
#   self.created_at = Time.now
# end
# 
# 
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
end
