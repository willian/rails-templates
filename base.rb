@railsapp_local_path = "rails-templates/railsapp/"

gem "ruby-debug"
rake("gems:install", :sudo => true)

run "cp config/database.yml config/database.sample.yml"

file ".gitignore", <<-END
.DS_Store
.autotest
Thumbs.db
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
rails-templates
public/javascripts/all.js
public/stylesheets/all.css
END

run %(rm public/javascripts/*)
run %(rm public/stylesheets/*)

git :init
git :add => ".", :commit => "-m 'initial commit'"

# Clonning rails-template repository
run %(git clone http://github.com/willian/rails-templates.git)

# Default Files
run %(cp #{@railsapp_local_path}config/routes.rb config/)

run %(mkdir app/views/home)
run %(mkdir app/views/layouts)
run %(mkdir lib/tasks)
run %(mkdir public/javascripts)
run %(mkdir public/stylesheets)
run %(mkdir test/factories)
run %(mkdir test/fixtures)
run %(mkdir test/functional)
run %(mkdir test/unit)
run %(mkdir test/unit/helpers)

run %(cp #{@railsapp_local_path}app/controllers/home_controller.rb app/controllers/)
run %(cp #{@railsapp_local_path}test/functional/home_controller_test.rb test/functional/)

run %(cp #{@railsapp_local_path}app/helpers/home_helper.rb app/helpers/)
run %(cp #{@railsapp_local_path}test/unit/helpers/home_helper_test.rb test/unit/helpers/)

run %(cp #{@railsapp_local_path}app/views/home/index.html.erb app/views/home/)

if yes?("Do you want to configurate the root path on routes.rb? Answer no if you use my auth rails-template")
  route %(map.root :controller => "home", :action => "index")
  run %(rm public/index.html)
end

run %(cp #{@railsapp_local_path}app/views/layouts/application.html.erb app/views/layouts/)

run %(cp #{@railsapp_local_path}lib/tasks/rcov.rake lib/tasks/)

run %(cp #{@railsapp_local_path}public/javascripts/application.js public/javascripts/)
run %(cp #{@railsapp_local_path}public/javascripts/jquery.js public/javascripts/)
run %(cp #{@railsapp_local_path}public/javascripts/rails.js public/javascripts/)

run %(cp #{@railsapp_local_path}public/stylesheets/application.css public/stylesheets/)

run %(echo '' >> config/environments/test.rb)
run %(echo 'config.active_record.schema_format = :sql' >> config/environments/test.rb)
run %(echo 'config.gem "redgreen" unless ENV.include?("TM_RUBY")' >> config/environments/test.rb)
run %(echo 'config.gem "rcov"' >> config/environments/test.rb)
run %(echo 'config.gem "thoughtbot-shoulda", :lib => "shoulda", :source => "http://gems.github.com"' >> config/environments/test.rb)
run %(echo 'config.gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"' >> config/environments/test.rb)
run %(echo 'config.gem "mocha"' >> config/environments/test.rb)
run %(echo 'config.gem "faker"' >> config/environments/test.rb)
run %(echo 'config.gem "fakeweb"' >> config/environments/test.rb)

rake("gems:install", :sudo => true)

git :add => ".", :commit => "-m 'generated default application'"

if yes?("Do you want to use my i18n files?")
  run %(mkdir config/locales)
  run %(cp #{@railsapp_local_path}config/locales/en.yml config/locales/)
  run %(cp #{@railsapp_local_path}config/locales/pt-BR.yml config/locales/)
  
  git :add => ".", :commit => "-m 'created the default i18n files'"
end

if yes?("Do you want to use my smtp configuration?")
  run %(cp #{@railsapp_local_path}lib/smtp_tls.rb lib/)
  
  run %(echo '' >> config/environment.rb)
  run %(echo '# SMTP Configuration' >> config/environment.rb)
  run %(echo 'require "smtp_tls"' >> config/environment.rb)
  
  smtp_address = ask("What is your smtp address? (use smtp.gmail.com for Gmail)")
  smtp_port = ask("What is your smtp port? (use 587 for Gmail)")
  user_name = ask("What is yout user name? (use your e-mail address for Gmail - like user@gmail.com)")
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

run %(rm -rf rails-templates)

