require 'rcov/rcovtask'
desc "Run test and generate coverage report"
Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
  t.rcov_opts << "--exclude test,config,/Library/*,lib/smtp_tls.rb"
end

namespace :test do
  desc "Run test, generate and open coverage report"
  task :coverage => "rcov" do
    `open coverage/index.html`
  end
end