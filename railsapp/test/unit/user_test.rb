require "#{File.dirname(__FILE__)}/../test_helper"

class UserTest < ActiveSupport::TestCase
  context "User" do
    context "relationships" do
      should_have_one :profile, :dependent => :destroy
    end # context "relationships"
  end # context "User"
end
