require "#{File.dirname(__FILE__)}/../test_helper"

class UsersControllerTest < ActionController::TestCase
  context "UserController" do
    context "on GET to :new" do
      setup do
        @user = User.new
        User.expects(:new).returns(@user)
        get :new 
      end

      should_respond_with :success
      should_assign_to(:user) { @user }
    end # context "on GET to :new"
    
    context "on POST to :create" do
      context "with valid data" do
        setup do
          user = Factory.build(:user)

          post :create,
               :user => { :login => user.login, :email => user.email, :password => "test1234", :password_confirmation => "test1234" },
               :profile => { :name => user.profile.name }
        end
        
        should_set_the_flash_to 'Cadastro realizado com sucesso!'
        should_redirect_to("Home page") { home_url }
      end # context "with valid data"
      
      context "without login" do
        setup do
          user = Factory(:user)
        
          post :create,
               :user => { :email => user.email, :password => "test1234", :password_confirmation => "test1234" },
               :profile => { :name => user.profile.name }
        end
        
        should_set_the_flash_to 'Dados inválidos.'
        should_render_template :new
      end # context "with invalid data"
    end # context "on POST to :create"
    
  end # context "UserController"
end
