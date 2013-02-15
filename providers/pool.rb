action :add do
  
  template ::File.join(node[:php][:fpm][:pools_dir], new_resource.name + ".conf") do
    mode "0644"
    source "fpm-pool.conf.erb"
    variables(
      :name => new_resource.name,
      :user => new_resource.user,
      :group => new_resource.group,
      :address => new_resource.address,
      :port => new_resource.port,
      :allow => new_resource.allow,
      :backlog => new_resource.backlog,
      :limits => new_resource.limits,
      :php => new_resource.php_var 
    )
    notifies :reload, resources(:service => "php-fpm")
    cookbook "php"
  end
end