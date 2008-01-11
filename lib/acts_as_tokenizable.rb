require 'digest' unless defined?(Digest)

module ActsAsTokenizable
  module ClassMethods
    def acts_as_tokenizable(h={})
      h[:update_token] == true ? 
        before_validation { |record| __create_random_token__(record) } :
        before_validation_on_create { |record| __create_random_token__(record) }
    end
    
  private
    
    def __create_random_token__(record_instance)
      random_string = ""        
      16.times { |i| random_string << (Kernel.rand(93)+33) }
      record_instance.token = value = Digest::MD5.hexdigest(random_string).to_s[0,16]                
    end
  end
end