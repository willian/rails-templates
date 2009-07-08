require "#{File.dirname(__FILE__)}/../test_helper"

class ProfileTest < ActiveSupport::TestCase
  context "Profile" do
    context "relationships" do
      should_belong_to :user
    end # context "relationships"
  end # context "Profile"
end
