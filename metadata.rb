name             'php'
maintainer       'LLC Express 42'
maintainer_email 'cookbooks@express42.com'
license          'MIT'
description      'Installs and configures php-fpm. Provides LWRPs for managing multiple instances.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

recipe           'php::default', 'Installs and configures default php-fpm instance.'

supports         'ubuntu'
