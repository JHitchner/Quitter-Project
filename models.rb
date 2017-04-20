class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
end

class Profile < ActiveRecord::Base
# has_one :user
belongs_to :user
# has_many :posts
end
