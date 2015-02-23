name             'myiis-cookbook'
maintainer       'Alex'
maintainer_email 'alex@example.com'
license          'All rights reserved'
description      'Installs/Configures myiis-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.4'

depends 'windows'
depends 'iis'
depends 'git'

recipe 'myiis-cookbook::default', 'Default recipe to install IIS and Google Chrome browser'
recipe 'myiis-cookbook::app-checkout', 'Recipe to deploy public git code'
