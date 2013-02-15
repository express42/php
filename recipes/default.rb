#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php-bcmath php-gd php-fpm php-cli php-common php-mbstring}.each do |pkg|
  package pkg do 
    action :install
  end
end

service "php-fpm" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template node[:php][:fpm][:main_conf] do
  source "fpm-main.conf.erb"
  mode 0644
  notifies :restart, resources(:service => "php-fpm"), :immediately
end

php_pool "www" do
  port "9000"
  action :add
end