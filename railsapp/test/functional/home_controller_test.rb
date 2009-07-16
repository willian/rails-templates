require "#{File.dirname(__FILE__)}/../test_helper"

class HomeControllerTest < ActionController::TestCase
  context "HomeController" do
    context "on GET to :index" do
      setup do
        @user = Factory(:user)
        get :index
      end

      should_assign_to(:user) { @user }
      should_respond_with :success
    end # context "on GET to :index"
  end # context "HomeController"
end
