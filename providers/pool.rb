def load_current_resource
  @current_resource = Chef::Resource::PhpPool.new(@new_resource.name)

  pool_path = node['php']['fpm']['pools_dir']

  # get list of files from conf dir
  files_list = []
  Dir.glob(pool_path + '/*').each { |path| files_list.push(path.sub(pool_path + '/', '')) }

  resources_list = []

  # get file names from resource_collection
  run_context.resource_collection.each do |resource|
    if resource.class == Chef::Resource::PhpPool
      resources_list.push(resource.name + '.conf')
    end
  end

  resource_files = []

  # get list of files created by provider
  resources_list.each do |r|
    files_list.each do |f|
      if f.match(r)
        resource_files.push(f)
      end
    end
  end

  # delete unnecessary files
  (files_list - resource_files).each do |f|
    ::File::unlink(pool_path + '/' + f)
    Chef::Log.info('Removing file ' + f + ' in directory ' + pool_path + ' ...')
  end
  @current_resource
end

action :add do
  template ::File.join(node['php']['fpm']['pools_dir'], new_resource.name + '.conf') do
    mode '0644'
    source 'fpm-pool.conf.erb'
    variables(
      :name => new_resource.name,
      :user => new_resource.user,
      :group => new_resource.group,
      :address => new_resource.address,
      :port => new_resource.port,
      :allow => new_resource.allow,
      :backlog => new_resource.backlog,
      :limits => new_resource.limits,
      :php => new_resource.php_var,
      :php_user => new_resource.php_user_var,
      :request_terminate_timeout => new_resource.request_terminate_timeout
    )
    notifies :reload, 'service[php5-fpm]'
    cookbook 'php'
  end
end
