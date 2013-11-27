set :application, 'ilovemyhouse'
set :repo_url, 'git@github.com:caok/ilovemyhouse.git'
set :branch, 'master'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p247'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :user, "rails"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

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
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.example"), "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "deploy:setup_config"

  #desc 'Restart application'
  #task :restart do
    #on roles(:app), in: :sequence, wait: 5 do
      ## Your restart mechanism here, for example:
      ## execute :touch, release_path.join('tmp/restart.txt')
    #end
  #end

  #after :restart, :clear_cache do
    #on roles(:web), in: :groups, limit: 3, wait: 10 do
      ## Here we can do anything such as:
      ## within release_path do
      ##   execute :rake, 'cache:clear'
      ## end
    #end
  #end

  after :finishing, 'deploy:cleanup'

end
