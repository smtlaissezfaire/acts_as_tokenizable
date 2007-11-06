require 'rubygems'
require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database  => ':memory:'

ActiveRecord::Schema.define do
  
  create_table :tokenizable_models do |t|
    t.column :foo, :string
    t.column :token, :string
  end  
end

require File.dirname(__FILE__) + "/../lib/acts_as_tokenizable"
require File.dirname(__FILE__) + "/../init"


class TokenizableModel < ActiveRecord::Base
  acts_as_tokenizable
end

