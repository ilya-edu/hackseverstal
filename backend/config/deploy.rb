
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :port, 2848
set :domain, 'cnc.kovalev.team'
set :deploy_to, '/home/serveriot/lct-api/'
set :user, 'serveriot'
set :environment, 'production'
set :branch, 'main'
set :rails_env, 'production'


set :repository, 'git@github.com:Vchekryzhov/lct_hack_api.git'

set :app_path, "#{fetch(:deploy_to)}/#{fetch(:current_path)}"
set :keep_releases, 5

task :environment do
  invoke :'rbenv:load'
end
set :shared_paths, [
  'config/database.yml', 'log', 'tmp',
  'public', 'config/master.key', 'storage'
]

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp', 'public', 'storage')
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml',
  'config/credentials/production.key',
)
namespace :nvm do
  task :load do
    command 'echo "-----> Loading nvm"'
    command %(
      source ~/.nvm/nvm.sh
    )
    command 'echo "-----> Now using nvm v.`nvm --version`"'
  end
end
task :setup do
  command %(mkdir -p "#{fetch(:deploy_to)}/shared/log")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/log")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/tmp")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/tmp/pids")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/tmp/pids")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/config")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/config")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/public")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public")

  command %(mkdir -p "#{fetch(:deploy_to)}/shared/public/storage")
  command %(chmod g+rx,u+rwx "#{fetch(:deploy_to)}/shared/public/storage")


  command %(touch "#{fetch(:deploy_to)}/shared/config/database.yml")
  command %(touch "#{fetch(:deploy_to)}/shared/config/credentials/production.key")
end

desc 'Deploys the current version to the server.'
task :deploy do
  deploy do
    invoke :'rbenv:load'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    command 'rbenv local 3.2.1'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'nvm:load'
    invoke :'rails:assets_precompile'
    on :launch do
      in_path(fetch(:current_path)) do
        command 'systemctl --user restart lct-api'
        command 'systemctl --user restart lct-sidekiq@{1..35}'
      end
    end
  end
end
