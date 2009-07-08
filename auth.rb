load_template "http://github.com/willian/rails-templates/raw/master/base.rb"

@railsapp_git_url = "http://github.com/willian/rails-templates/raw/master/railsapp/"

if yes?("Do you want to use authlogic?")
  gem "authlogic", :source => "http://gems.github.com"
  rake("gems:install", :sudo => true)
  
  run %(wget #{@railsapp_git_url}app/application_controller.rb && mv application_controller.rb app/)
  run %(wget #{@railsapp_git_url}helpers/application_helper.rb && mv application_helper.rb helpers/)
  
  run %(wget #{@railsapp_git_url}app/user_sessions_controller.rb && mv user_sessions_controller.rb app/)
  run %(wget #{@railsapp_git_url}helpers/user_sessions_helper.rb && mv user_sessions_helper.rb helpers/)
  
  run %(wget #{@railsapp_git_url}models/profile.rb && mv profile.rb models/)
  run %(wget #{@railsapp_git_url}models/user.rb && mv user.rb models/)
  run %(wget #{@railsapp_git_url}models/user_session.rb && mv user_session.rb models/)
  
  run %(wget #{@railsapp_git_url}test/factories/profile_factory.rb && mv profile_factory.rb test/factories/)
  run %(wget #{@railsapp_git_url}test/factories/user_factory.rb && mv user_factory.rb test/factories/)
  
  run %(wget #{@railsapp_git_url}test/fixtures/profiles.yml && mv profiles.yml test/fixtures/)
  run %(wget #{@railsapp_git_url}test/fixtures/users.yml && mv users.yml test/fixtures/)
  
  run %(wget #{@railsapp_git_url}test/functional/user_sessions_controller_test.rb && mv user_sessions_controller_test.rb test/functional/)
  
  run %(wget #{@railsapp_git_url}test/unit/helpers/user_sessions_helper_test.rb && mv user_sessions_helper_test.rb test/unit/helpers/)
  run %(wget #{@railsapp_git_url}test/unit/profile_test.rb && mv profile_test.rb test/unit/)
  run %(wget #{@railsapp_git_url}test/unit/user_test.rb && mv user_test.rb test/unit/)
  
  run %(wget #{@railsapp_git_url}test/test_helper.rb && mv test_helper.rb test/)
  
  run %(mkdir views/user_sessions)
  run %(wget #{@railsapp_git_url}views/user_sessions/new.html.erb && mv new.html.erb views/user_sessions/)
  
  run %(mkdir db/migrate)
  run %(wget #{@railsapp_git_url}db/migrate/20090528020553_create_users.rb && mv 20090528020553_create_users.rb db/migrate/)
  run %(wget #{@railsapp_git_url}db/migrate/20090610215322_create_profiles.rb && mv 20090610215322_create_profiles.rb db/migrate/)
  
  route %(map.root :controller => "user_sessions", :action => "new")
  route %(map.resources :users)
  route %(map.resource :user_session)
  
  route %(map.login '/login', :controller => "user_sessions", :action => "new")
  route %(map.logout '/logout', :controller => "user_sessions", :action => "destroy")
  route %(map.home '/home', :controller => "home", :action => "index")
  
  git :add => ".", :commit => "-m 'generated authentication configuration'"
end