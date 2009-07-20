require "#{File.dirname(__FILE__)}/../test_helper"

class PasswordResetsControllerTest < ActionController::TestCase
  context "PasswordResetsController" do
    context "on GET to :new" do
      setup do
        get :new 
      end

      should_respond_with :success
    end # context "on GET to :new"
    
    context "on POST to :create" do
      context "with a invalid email address" do
        setup do
          post :create, :email => "test@emailaddress.com"
        end
        
        should_render_template :new
        should_set_the_flash_to "No user was found with that email address"
      end # context "with invalid mail"
      
      context "with an valid email address" do
        setup do
          @user = Factory(:user)
          UserSession.find.destroy
          
          post :create, :email => @user.email
        end
        
        should_set_the_flash_to "Instructions to reset your password have been emailed to you. Please check your email."
        should_redirect_to("login page") { root_url }
      end # context "with invalid mail"
    end # context "on POST to :create"
    
    context "on GET to :edit" do
      context "with a invalid perishable_token" do
        setup do
          @user = Factory(:user)
          UserSession.find.destroy

          get :edit, :id => @user.perishable_token
        end
        
        should_set_the_flash_to "We're sorry, but we could not locate your account. If you are having issues try copying and pasting the URL from your email into your browser or restarting the reset password process."
        should_redirect_to("login page") { root_url }
      end # context "with a invalid perishable_token"
      
      context "with an valid perishable_token" do
        setup do
          @user = Factory(:user)
          UserSession.find.destroy
          @user.deliver_password_reset_instructions!

          get :edit, :id => @user.perishable_token
        end

        should_respond_with :success
      end # context "with an valid perishable_token"
    end # context "on GET to :edit"
    
    context "on PUT to :update" do
      setup do
        @user = Factory(:user)
        UserSession.find.destroy
        @user.deliver_password_reset_instructions!
      end
      
      context "with a invalid data" do
        setup do
          put :update, :id => @user.perishable_token, :user => {:password => "test1234", :password_confirmation => "test12345"}
        end
        
        should_render_template :edit
      end # context "with invalid data"
      
      context "with an valid data" do
        setup do
          put :update, :id => @user.perishable_token, :user => {:password => "test1234", :password_confirmation => "test1234"}
        end
        
        should_set_the_flash_to "Password successfully updated"
        should_redirect_to("home page") { home_url }
      end # context "with invalid mail"
    end # context "on PUT to :update"
  end # context "PasswordResetsController"  
end
