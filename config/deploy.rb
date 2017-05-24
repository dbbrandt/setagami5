# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "setagami5"
set :repo_url, "git@github.com:dbbrandt/setagami5.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/precidix/srv/setagami5"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# Random issues with deploy failing due to security problems is resolved by this line.
set :ssh_options,     { :forward_agent => true }

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/puma.rb"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Puma:
set :puma_conf, "#{shared_path}/config/puma.rb"

namespace :deploy do
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  after 'puma:smart_restart', 'nginx:restart'
end

# Server name for nginx, space separated values
# No default value
set :nginx_domains, "www.setagami.com"

# Redirected domains, all these will have a permanent redirect to the first of :nginx_domains
# No default value
#set :nginx_redirected_domains, "bar.com other.com"

# Sudo usage can be enables on task and/or path level.
# If sudo is enabled for a specific task (i.e. 'nginx:site:add') every
# command in that task will be run using sudo priviliges.
# If sudo is enables for a specific path (i.e. :nginx_sites_enabled_dir)
# only command manipulating that directory will be run using sudo privileges.
# Note: When options overlap, sudo is used if either option permits it.
#
# Everything is run as sudo per default.
# set :nginx_sudo_paths, [:nginx_log_path, :nginx_sites_enabled_dir, :nginx_sites_available_dir]
# set :nginx_sudo_tasks, ['nginx:start', 'nginx:stop', 'nginx:restart', 'nginx:reload', 'nginx:configtest', 'nginx:site:add', 'nginx:site:disable', 'nginx:site:enable', 'nginx:site:remove' ]

# nginx service script
# Defaults to using the 'service' convinience script.
# You might prefer using the init.d instead depending on sudo privilages.
# default value: "service nginx"
set :nginx_service_path, "/etc/init.d/nginx"

# Roles the deploy nginx site on,
# default value: :web
#set :nginx_roles, :web

# Path, where nginx log file will be stored
# default value:  "#{shared_path}/log"
# set :nginx_log_path, "#{shared_path}/log"

# Path where to look for static files
# default value: "public"
#set :nginx_static_dir, "my_static_folder"

# Path where nginx available site are stored
# default value: "/etc/nginx/sites-available"
#set :nginx_sites_available_dir, "/opt/nginx/sites-available"

# Name of file stored in site-enabled/available
# default value: "#{fetch :application}"
set :nginx_application_name, "#{fetch :application}-#{fetch :stage}.conf"

# Path where nginx available site are stored
# default value: "/etc/nginx/sites-enabled"
#set :nginx_sites_enabled_dir, "/opt/nginx/sites-enabled"

# Path to look for custom config template
# `:default` will use the bundled nginx template
# default value: :default
#set :nginx_template, "#{stage_config_path}/#{fetch :stage}/nginx.conf.erb"

# Use SSL on port 443 to serve on https. Every request to por 80
# will be rewritten to 443
# default value: false
#set :nginx_use_ssl, false

# Name of SSL certificate file
# default value: "#{application}.crt"
#set :nginx_ssl_certificate, 'my-domain.crt'

# SSL certificate file path
# default value: "/etc/ssl/certs"
#set :nginx_ssl_certificate_path, "#{shared_path}/ssl/certs"

# Name of SSL certificate private key
# default value: "#{application}.key"
#set :nginx_ssl_certificate_key, 'my-domain.key'

# SSL certificate private key path
# default value: "/etc/ssl/private"
#set :nginx_ssl_certificate_key_path, "#{shared_path}/ssl/private"

# You can set a timeout value in seconds
# nginx's default is 30 seconds
#set :nginx_read_timeout, 30

# Whether you want to server an application through a proxy pass
# default value: true
#set :app_server, true

# Socket file that nginx will use as upstream to serve the application
# Note: Socket upstream has priority over host:port upstreams
# no default value
#set :app_server_socket, "#{shared_path}/sockets/unicorn-#{fetch :application}.sock"

# The host that nginx will use as upstream to server the application
# default value: 127.0.0.1
#set :app_server_host, "127.0.0.1"

# The port the application server is running on
# no default value
#set :app_server_port, 8080
