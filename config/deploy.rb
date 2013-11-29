#encoding:utf-8
require 'bundler/capistrano'

set :application, "ilovemyhouse"
set :repository, "https://github.com/caok/ilovemyhouse.git"
#set :repository, File.expand_path('../../.git/', __FILE__)
set :branch, "master"

set :scm, :git

set :user, "rails"
set :use_sudo, false

# 部署路径修改为当前用户的目录，如果用默认的根目录且没有root权限会引起Permission denied的错误
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache # 不要每次都获取全新的repository
set :deploy_server, '192.241.175.10'
set :rails_env, "production" #added for delayed job

set :bundle_without,  [:development, :test]

# for rbenv
set :rbenv_version, "2.0.0-p247"
set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
  'RBENV_VERSION' => "#{rbenv_version}",
}

role :web, "#{deploy_server}"                          # Your HTTP server, Apache/etc
role :app, "#{deploy_server}"                          # This may be the same as your `Web` server
role :db,  "#{deploy_server}", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  desc "Start Application"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop Application"
  task :stop, :roles => :app do
    run "kill -QUIT `cat #{shared_path}/pids/unicorn.#{application}.pid`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{shared_path}/pids/unicorn.#{application}.pid`"
  end

  desc "Populates the Production Database"
  task :seed do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:seed"
  end

  task :setup_config, roles: :app do
    #sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.example"), "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml  #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update","deploy:symlink_config"
end

namespace :carrierwave do
  desc "Symlink the upload files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/uploads && ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

after 'deploy:update', 'carrierwave:symlink'

desc 'copy ckeditor nondigest assets'
task :copy_nondigest_assets, roles: :app do
  #run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:copy_nondigest_assets"
  run "cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} ckeditor:assets:precompile"
end
after 'deploy:assets:precompile', 'copy_nondigest_assets'

