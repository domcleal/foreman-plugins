set :application, "foreman-plugins"

set :repository, "."
set :scm, :none
set :deploy_via, :copy
set :copy_exclude, [".git"]

set :deploy_to, "/usr/share/#{application}"

set :user, "root"
set :use_sudo, false
set :gateway, "radon.usersys.redhat.com"

role :foreman, "foreman.fm.example.net"

namespace :deploy do
  task :finalize_update do
    location = fetch(:template_dir, "config/deploy") + "/#{application}.rb.erb"
    put ERB.new(File.read(location)).result(binding), "/usr/share/foreman/bundler.d/#{application}.rb"
    run %Q{#{try_sudo} touch /usr/share/foreman/tmp/restart.txt}
  end
end
