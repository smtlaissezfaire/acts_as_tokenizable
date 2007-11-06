# ActsAsTokenizable
module ActsAsTokenizable
  module ClassMethods
    def acts_as_tokenizable
      after_create do |record|
        random_string = ""        
        16.times { |i| random_string << (Kernel.rand(93)+33) }
        record.token = value = Digest::MD5.hexdigest(random_string).to_s[0,16]        
      end
    end
  end
  
end