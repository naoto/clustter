class User < ActiveRecord::Base
  has_and_belongs_to_many :clusters, :join_table => 'matrices'
end
