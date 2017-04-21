class User < ActiveRecord::Base
  has_one :profile
  has_many :posts, dependent: :destroy
end

class Profile < ActiveRecord::Base
  belongs_to :user
# has_many :posts
end

class Post < ActiveRecord::Base
  belongs_to :user
end
