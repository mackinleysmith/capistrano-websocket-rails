namespace :load do
  set :websocket_rails_default_hooks, -> { true }
  set :websocket_rails_pid, -> { shared_path.join 'tmp', 'pids', 'websocket_rails.pid' }
  set :websocket_rails_env, -> { fetch :rack_env, fetch(:rails_env, fetch(:stage)) }
  set :websocket_rails_role, -> { :app }
end

namespace :deploy do
  before :starting, :check_websocket_rails_hooks do
    invoke 'websocket_rails:add_default_hooks' if fetch(:websocket_rails_default_hooks)
  end
  after :publishing, :restart_websocket_rails_server do
    invoke 'websocket_rails:restart_server' if fetch(:websocket_rails_default_hooks)
  end
end

namespace :websocket_rails do

  desc 'Start websocket-rails server'
  task :start_server do
    on roles(fetch(:websocket_rails_role)) do
      within(release_path) { start_server fetch(:websocket_rails_pid) }
    end
  end

  desc 'Stop websocket-rails server'
  task :stop_server do
    on roles(fetch(:websocket_rails_role)) do
      within(release_path) { stop_server fetch(:websocket_rails_pid) }
    end
  end

  desc 'Restart websocket-rails server'
  task :restart_server do
    on roles(fetch(:websocket_rails_role)) do
      within(release_path) { restart_server fetch(:websocket_rails_pid) }
    end
  end

  task :add_default_hooks do
    after 'deploy:updated',   'websocket_rails:stop_server'
    after 'deploy:reverted',  'websocket_rails:stop_server'
    after 'deploy:published', 'websocket_rails:start_server'
  end

  def start_server(pid_file)
    info 'Starting websocket-rails server...'
    run_rake_command 'start_server'
    info 'Websocket-rails server started.'
  end
  def stop_server(pid_file)
    if pid_file_exists? pid_file
      info 'Stopping websocket-rails server...'
      run_rake_command 'stop_server'
      info 'Websocket-rails server stopped.'
    else
      info 'Websocket-rails server not running.'
    end
  end
  def restart_server(pid_file)
    stop_server(pid_file)
    start_server(pid_file)
  end
  def pid_file_exists?(pid_file); test "[ -f #{pid_file} ]" end
  def run_rake_command(cmd)
    with rails_env: fetch(:websocket_rails_env) do
      rake "websocket_rails:#{cmd}"
    end
  end

end
