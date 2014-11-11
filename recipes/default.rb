#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(php5-gd php5-fpm php5-cli php5-common).each do |pkg|
  package pkg do
    action :install
  end
end

if node['platform_version'] == '14.04'
  cookbook_file '/etc/init/php5-fpm.conf' do
    source 'php5-fpm.conf'
    owner 'root'
    group 'root'
    mode '0644'
  end
  service 'php5-fpm' do
    supports status: true, restart: true
    action [:enable, :start]
    provider Chef::Provider::Service::Upstart
  end
else
  service 'php5-fpm' do
    supports status: true, restart: true, reload: true
    action [:enable, :start]
  end
end

template node['php']['fpm']['main_conf'] do
  source 'fpm-main.conf.erb'
  mode '0644'
  notifies :restart, 'service[php5-fpm]', :immediately
end

if node['php']['fpm']['create_default_pool']
  php_pool 'www' do
    port '9000'
    action :add
  end
end
