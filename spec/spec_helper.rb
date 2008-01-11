require 'rubygems'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database  => ':memory:'

ActiveRecord::Schema.define do
  
  create_table :default_tokenizable_models do |t|
    t.column :foo, :string
    t.column :token, :string
  end
  
  create_table :tokenizable_model_with_update_trues do |t|
    t.column :foo, :string
    t.column :token, :string
  end
  
  create_table :tokenizable_model_with_update_falses do |t|
    t.column :foo, :string
    t.column :token, :string
  end

end

require File.dirname(__FILE__) + "/../lib/acts_as_tokenizable"
require File.dirname(__FILE__) + "/../init"


class DefaultTokenizableModel < ActiveRecord::Base
  acts_as_tokenizable
end

class TokenizableModelWithUpdateFalse < ActiveRecord::Base
  acts_as_tokenizable :update_token => false
end

class TokenizableModelWithUpdateTrue < ActiveRecord::Base
  acts_as_tokenizable :update_token => true
end

