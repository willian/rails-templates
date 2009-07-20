require "#{File.dirname(__FILE__)}/../test_helper"

class UserTest < ActiveSupport::TestCase
  context "User" do
    context "relationships" do
      should_have_one :profile, :dependent => :destroy
    end # context "relationships"
    
    context "password reset" do
      setup do
        @user = Factory.build(:user)
        @user.save
        Notifier.expects(:deliver_password_reset_instructions).with(@user)
        
        @user_perishable_token = @user.perishable_token
        @user.deliver_password_reset_instructions!
      end
      
      # should_change "User.last.perishable_token", :from => @user_perishable_token
    end # context "password reset"
    
  end # context "User"
end
