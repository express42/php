#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2013, LLC Express 42
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
    supports status: true, restart: true, reload: true
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
  notifies :reload, 'service[php5-fpm]'
end

php_pool 'www' do
  port '9000'
  action :add
  only_if { node['php']['fpm']['create_default_pool'] }
end
