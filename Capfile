load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'

namespace :deploy do

	task :start, :roles => :app do
		run "cd #{current_path}/app/views/layouts && mv application.html.online application.html.erb"
		run "cd #{current_path}/config && mv twitter.yml.online twitter.yml"
		run "cd #{current_path} && chmod 755 #{chmod755}"
		run "touch #{current_path}/tmp/restart.txt"
	end

	task :restart, :roles => :app do
		run "cd #{current_path}/app/views/layouts && mv application.html.online application.html.erb"
		run "cd #{current_path}/config && mv twitter.yml.online twitter.yml"
		run "cd #{current_path} && chmod 755 #{chmod755}"
		run "touch #{current_path}/tmp/restart.txt"
	end
	
end