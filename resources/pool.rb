actions :add, :delete
 
 
attribute :name, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String, :default => "nobody"
attribute :group, :kind_of => String, :default => "nobody"
attribute :allow, :kind_of => String, :default => "127.0.0.1"
attribute :address, :kind_of => String, :default => "127.0.0.1"
attribute :port, :kind_of => String
attribute :backlog, :kind_of => Integer, :default => -1
attribute :limits, :kind_of => Hash, :default => {:core => 0, :files => 1024, :requests => 500, :children => 5, :spare_children => { :min => 1, :max => 3 } }
attribute :php_var, :kind_of => Hash, :default => {}


#php_pool "www" do
#  address "127.0.0.1"
#  user "nobody"
#  group "nobody"
#  allow "127.0.0.1"
#  backlog "-1"
#  limits :core => 0, :files => 1024, :requests => 500, :children => 5, :spare_children => { :min => 1, :max => 3 } 
#  php_var 'register_globals' => true, 'short_open_tag' => true, 'display_errors' => false, 'error_reporting' => 'E_ALL &amp; ~E_DEPRECATED', 'max_execution_time' => '60', 'date.timezone' => 'Europe/Moscow'
#  action :add
#end