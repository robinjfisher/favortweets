default_run_options[:pty] = true
set :application, ""
set :scm, ""
set :user, ""
set :scm_passphrase, ""
set :repository, ""
ssh_options[:forward_agent] = true
set :use_sudo, false
set :branch, "master"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

set :port, "30000"
set :deploy_to, "/home/#{user}/public_html/#{application}"
set :deploy_via, :remote_cache
set :chmod755, "app config db lib public vendor config.ru"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "67.207.138.70"
role :web, "67.207.138.70"
role :db,  "67.207.138.70", :primary => true

set :runner, "#{user}"

task :after_update_code, :roles => :app do
  run "rm -rf #{release_path}/public/robots.txt"
  run "mkdir -p #{shared_path}/system/robots"
  run "ln -s #{shared_path}/system/robots/robots.txt #{release_path}/public/robots.txt"
  run "rm -rf #{release_path}/public/images"
  run "ln -s #{shared_path}/system/images #{release_path}/public/images"
end
