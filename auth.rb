load_template "http://github.com/willian/rails-templates/raw/master/base.rb"

@railsapp_local_path = "rails-templates/railsapp/"

# Clonning rails-template repository
run %(git clone git://github.com/willian/rails-templates.git)

if yes?("Do you want to use authlogic?")
  gem "authlogic", :source => "http://gems.github.com"
  rake("gems:install", :sudo => true)
  
  run %(cp #{@railsapp_local_path}app/controllers/application_controller.rb app/controllers/)
  run %(cp #{@railsapp_local_path}app/helpers/application_helper.rb app/helpers/)
  
  run %(cp #{@railsapp_local_path}app/controllers/user_sessions_controller.rb app/controllers/)
  run %(cp #{@railsapp_local_path}test/functional/user_sessions_controller_test.rb test/functional/)
  
  run %(cp #{@railsapp_local_path}app/helpers/user_sessions_helper.rb app/helpers/)
  run %(cp #{@railsapp_local_path}test/unit/helpers/user_sessions_helper_test.rb test/unit/helpers/)
  
  run %(cp #{@railsapp_local_path}app/controllers/users_controller.rb app/controllers/)
  run %(cp #{@railsapp_local_path}test/functional/users_controller_test.rb test/functional/)
  
  run %(cp #{@railsapp_local_path}app/helpers/users_helper.rb app/helpers/)
  run %(cp #{@railsapp_local_path}test/unit/helpers/users_helper_test.rb test/unit/helpers/)
  
  run %(cp #{@railsapp_local_path}app/models/profile.rb app/models/)
  run %(cp #{@railsapp_local_path}test/factories/profile_factory.rb test/factories/)
  run %(cp #{@railsapp_local_path}test/fixtures/profiles.yml test/fixtures/)
  run %(cp #{@railsapp_local_path}test/unit/profile_test.rb test/unit/)

  run %(cp #{@railsapp_local_path}app/models/user.rb app/models/)
  run %(cp #{@railsapp_local_path}test/factories/user_factory.rb test/factories/)
  run %(cp #{@railsapp_local_path}test/fixtures/users.yml test/fixtures/)
  run %(cp #{@railsapp_local_path}test/unit/user_test.rb test/unit/)

  run %(cp #{@railsapp_local_path}app/models/user_session.rb app/models/)

  run %(cp #{@railsapp_local_path}test/test_helper.rb test/)

  run %(mkdir app/views/user_sessions)
  run %(cp #{@railsapp_local_path}app/views/user_sessions/new.html.erb app/views/user_sessions/)

  run %(mkdir app/views/users)
  run %(cp #{@railsapp_local_path}app/views/users/new.html.erb app/views/users/)
  
  run %(mkdir db/migrate)
  run %(cp #{@railsapp_local_path}db/migrate/20090528020553_create_users.rb db/migrate/)
  run %(cp #{@railsapp_local_path}db/migrate/20090610215322_create_profiles.rb db/migrate/)
  
  route %(map.root :controller => "user_sessions", :action => "new")
  route %(map.resources :users)
  route %(map.resource :user_session)
  
  route %(map.login '/login', :controller => "user_sessions", :action => "new")
  route %(map.logout '/logout', :controller => "user_sessions", :action => "destroy")
  route %(map.home '/home', :controller => "home", :action => "index")

  run %(git rm public/index.html)
  
  git :add => ".", :commit => "-m 'generated authentication configuration'"
end

run %(rm -rf rails-templates)

