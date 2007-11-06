
ActiveRecord::Base.instance_eval do
  class << self
    include ActsAsTokenizable::ClassMethods
  end
end