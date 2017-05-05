class User < ActiveRecord::Base
  has_one :profile, dependent: :delete
  has_many :posts, dependent: :delete_all
end

class Profile < ActiveRecord::Base
  belongs_to :user
end

class Post < ActiveRecord::Base
  belongs_to :user
end
