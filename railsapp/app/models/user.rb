class User < ActiveRecord::Base
  # PLUGINS
  acts_as_authentic do |c|
    c.login_field :email
  end
  
  # RELATIONSHIPS
  has_one :profile, :dependent => :destroy
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
