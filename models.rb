class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
end

class Profile < ActiveRecord::Base
  # belongs_to :user
  has_one :user
# has_many :posts
end
