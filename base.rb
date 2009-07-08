@railsapp_git_url = "http://github.com/willian/rails-templates/raw/master/railsapp/"

git :init

gem "ruby-debug"
rake("gems:install", :sudo => true)

run "cp config/database.yml config/database.sample.yml"

file ".gitignore", <<-END
.DS_Store
.autotest
*~
*.log
*.pid
config/database.yml
coverage/
db/*.sqlite3
db/*_structure.sql
db/schema.*
log
tmp/**/*
END

git :add => ".", :commit => "-m 'initial commit'"

# Default Files
run %(wget #{@railsapp_git_url}config/routes.rb && mv routes.rb config/)

run %(wget #{@railsapp_git_url}app/home_controller.rb && mv home_controller.rb app/)
run %(wget #{@railsapp_git_url}helpers/home_helper.rb && mv home_helper.rb helpers/)

run %(mkdir views/home)
run %(wget #{@railsapp_git_url}views/home/index.html.erb && mv index.html.erb views/home/)

run %(mkdir views/layouts)
run %(wget #{@railsapp_git_url}views/layouts/application.html.erb && mv application.html.erb views/layouts/)

run %(mkdir lib/tasks)
run %(wget #{@railsapp_git_url}lib/tasks/rcov.rake && mv rcov.rake lib/tasks/)

run %(mkdir public/javascripts)
run %(rm public/javascripts/*)
run %(wget #{@railsapp_git_url}public/javascripts/application.js && mv application.js public/javascripts/)
run %(wget #{@railsapp_git_url}public/javascripts/jquery.js && mv jquery.js public/javascripts/)
run %(wget #{@railsapp_git_url}public/javascripts/rails.js && mv rails.js public/javascripts/)

run %(mkdir public/stylesheets)
run %(rm public/stylesheets/*)
run %(wget #{@railsapp_git_url}public/stylesheets/application.css && mv application.css public/stylesheets/)

run %(mkdir test/factories)
run %(mkdir test/fixtures)

run %(mkdir test/functional)
run %(wget #{@railsapp_git_url}test/functional/home_controller_test.rb && mv home_controller_test.rb test/functional/)

run %(mkdir test/unit)
run %(mkdir test/unit/helpers)
run %(wget #{@railsapp_git_url}test/unit/helpers/home_helper_test.rb && mv home_helper_test.rb test/unit/helpers/)

if yes?("Do you want to configurate the root path on routes.rb?")
  route %(map.root :controller => "home", :action => "index")
end
git :add => ".", :commit => "-m 'generated default application'"

if yes?("Do you want to use my i18n files?")
  run %(mkdir config/locales)
  run %(wget #{@railsapp_git_url}config/locales/en.yml && mv en.yml config/locales/)
  run %(wget #{@railsapp_git_url}config/locales/pt-BR.yml && mv pt-BR.yml config/locales/)
  
  git :add => ".", :commit => "-m 'created the default i18n files'"
end

if yes?("Do you want to use my smtp configuration?")
  run %(wget #{@railsapp_git_url}lib/smtp_tls.rb && mv smtp_tls.rb lib/)
  
  run %(echo '# SMTP Configuration' >> config/environment.rb)
  run %(echo 'require "smtp_tls"' >> config/environment.rb)
  
  smtp_address = ask("What is your smtp address?")
  smtp_port = ask("What is your smtp port? (default is 587)")
  smtp_port = "587" if smtp_port.nil?
  user_name = ask("What is yout user name?")
  password = ask("What is your password?")
  
  run %(echo 'ActionMailer::Base.smtp_settings = {' >> config/environment.rb)
  run %(echo '  :address => "#{smtp_address}",' >> config/environment.rb)
  run %(echo '  :port => #{smtp_port},' >> config/environment.rb)
  run %(echo '  :authentication => :plain,' >> config/environment.rb)
  run %(echo '  :user_name => "#{user_name}",' >> config/environment.rb)
  run %(echo '  :password => "#{password}"' >> config/environment.rb)
  run %(echo '}' >> config/environment.rb)
  
  git :add => ".", :commit => "-m 'generated smtp configuration'"
end

run %(rm railsapp*)
run %(rm app*)