class User < ActiveRecord::Base
has_one :profile
end

class Profile < ActiveRecord::Base
# has_one :user
belongs_to :user
end
