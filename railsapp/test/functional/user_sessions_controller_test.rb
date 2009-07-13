require "#{File.dirname(__FILE__)}/../test_helper"

class UserSessionsControllerTest < ActionController::TestCase
  context "UserSessionsController" do
    context "on GET to :new" do
      context "when a logged user doesn't exists" do
        setup do
          get :new
        end
      
        should_respond_with :success
      end # context "when a logged user doesn't exists"
      
      context "when a logged user exists" do
        setup do
          Factory(:user)
          get :new
        end

        should_set_the_flash_to 'You must be logged out to access this page'
        should_redirect_to("the user's home page") { home_path }
      end # context "when a logged user exists"
    end # context "on GET to :new"

    context "on POST to :create" do
      context "with a valid email" do
        setup do
          user = User.create(
            :login => "willian",
            :email => "test@domain.com",
            :password => 'test1234',
            :password_confirmation => 'test1234'
          )
          
          post :create, :user_session => { :password => "test1234", :email => user.email }
        end
    
        should_set_the_flash_to 'Login successful!'
        should_redirect_to("the user's home page") { home_path }
      end # context "with a valid email"
      
      context "with an invalid email" do
        setup do
          post :create, :user_session => { :password => "test1234", :email => 'teste@teste.com.br' }
        end
        
        should_respond_with :success
        should_render_template :new
      end # context "with an invalid email"
    end # context "on POST to :create"
    
    context "on DELETE to :destroy" do
      context "when a logged user doesn't exists" do
        setup do
          delete :destroy
        end
    
        should_set_the_flash_to 'You must be logged in to access this page'
        should_redirect_to("login page") { login_path }
      end # context "when a logged user doesn't exists"
      
      context "when a logged user exists" do
        setup do
          Factory(:user)
          delete :destroy
        end
    
        should "return nil for the session" do
          assert_nil UserSession.find
        end # should "return nil for the session"
    
        should_set_the_flash_to 'Logout successful!'
        should_redirect_to("login page") { login_path }
      end # context "when a logged user exists"
    end # context "on DELETE to :destroy"
  end # context "UserSessionsController"
end
