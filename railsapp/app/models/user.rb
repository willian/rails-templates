class User < ActiveRecord::Base
  # PLUGINS
  acts_as_authentic do |c|
    c.login_field :email
  end
  
  # RELATIONSHIPS
  has_one :profile, :dependent => :destroy
end
