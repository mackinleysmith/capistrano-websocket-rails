if Gem::Specification.find_by_name('capistrano').version >= Gem::Version.new('3.0.0')
  load File.expand_path('../tasks/websocket-rails.rake', __FILE__)
else
  # require_relative 'tasks/capistrano2'
  raise 'Capistrano (< 3.0.0) is not supported at this time.'
end
