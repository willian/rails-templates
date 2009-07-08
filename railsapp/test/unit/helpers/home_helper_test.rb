require "#{File.dirname(__FILE__)}/../../test_helper"

class HomeHelperTest < ActionView::TestCase
  context "HomeHelper" do
    context "greet" do
      context "when time between 0 AM and 12 PM" do
        setup do
          @user = Factory(:user)
          @time = Time.mktime(Time.now.year, Time.now.month, Time.now.day, 10, 0, 0, 0)
          Time.stubs(:now).returns(@time)
        end

        should "return the morning message" do
          assert_equal("<h2>Bom Dia, #{@user.profile.name}</h2>", greet(@user))
        end # should "return the morning message"
      end # context "when time between 0 AM and 12 PM"
      
      context "when time between 12 AM and 18 PM" do
        setup do
          @user = Factory(:user)
          @time = Time.mktime(Time.now.year, Time.now.month, Time.now.day, 13, 0, 0, 0)
          Time.stubs(:now).returns(@time)
        end

        should "return the afternoon message" do
          assert_equal("<h2>Boa Tarde, #{@user.profile.name}</h2>", greet(@user))
        end # should "return the afternoon message"
      end # context "when time between 12 AM and 18 PM"
      
      context "when time between 18 AM and 24 PM" do
        setup do
          @user = Factory(:user)
          @time = Time.mktime(Time.now.year, Time.now.month, Time.now.day, 20, 0, 0, 0)
          Time.stubs(:now).returns(@time)
        end

        should "return the night message" do
          assert_equal("<h2>Boa Noite, #{@user.profile.name}</h2>", greet(@user))
        end # should "return the night message"
      end # context "when time between 18 AM and 24 PM"
    end # context "greet"    
  end # context "HomeHelper"  
end
