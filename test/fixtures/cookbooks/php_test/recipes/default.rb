include_recipe 'apt'
include_recipe 'php'

php_pool 'test1' do
  port '9001'
  action :add
end

php_pool 'test2' do
  port '9002'
  action :add
end
