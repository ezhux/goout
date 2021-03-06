default_run_options[:pty] = true
set :application, "goout"
set :repository,  "git@github.com:ezhux/goout.git"
set :deploy_to, "/home/ezhux/goout"

set :domain, "go-out.lt"
set :scm, :git
set :scm_verbose, true
set :branch, 'master'
set :use_sudo, false
set :ssh_options, { :forward_agent => true }
set :keep_releases, 3

set :user, "ezhux"

#set :deploy_via, :remote_cache
set :deploy_via, :copy

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain 

before "deploy:restart", "environment:production"
before "deploy:start", "environment:production"
before "deploy:restart", "db:symlink" 
before "deploy:migrate", "db:symlink" 
after "deploy:symlink", "customs:symlink"
after "deploy", "deploy:cleanup"

namespace :environment do
  task :production do
    set :rails_env, 'production' 
  end
end

namespace(:customs) do
 task :symlink, :roles => :app do
    run <<-CMD
      ln -nfs #{shared_path}/avatars #{release_path}/public/avatars
    CMD
  end
end

namespace :deploy do
   task :start do 
     run "#{try_sudo} touch #{File.join(current_path,'log','feed_updater.log')}"
     run "#{try_sudo} touch #{File.join(current_path,'log','wikilog.log')}"
   end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

namespace :db do
  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs ~/.ssh/database.yml #{release_path}/config/database.yml"
  end
end
