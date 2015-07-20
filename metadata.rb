name             'myiis-cookbook'
maintainer       'Great Websites Inc'
maintainer_email 'contact@example.com'
license          'All rights reserved'
description      'Installs/Configures myiis-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.4.25'

depends 'git'
depends 'msdeploy'

supports 'windows'

recipe 'myiis-cookbook::default', 'Default recipe to install IIS'
recipe 'myiis-cookbook::app_checkout', 'Recipe to deploy a website from a git repository'
recipe 'myiis-cookbook::app_msdeploy_import', 'Recipe to import an msdeploy package from an http(s) location'
recipe 'myiis-cookbook::install_google_chrome', 'Recipe to install the Google Chrome browser'
