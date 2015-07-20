# Attributes used by the 'app_checkout' recipe to clone the specified git repository into the IIS directory
default['myiis-cookbook']['git-repo'] = 'https://github.com/alexpop/myhtml-app'
default['myiis-cookbook']['doc-root'] = 'c:/inetpub/wwwroot'
default['myiis-cookbook']['git-revision'] = 'master'

# Attribute used by the 'app_msdeploy_import' recipe to specify where to download the msdeploy package from
default['myiis-cookbook']['msdeploy']['zip'] = 'https://s3-eu-west-1.amazonaws.com/apop-bucket/all_sites-latest.zip'

# Attribute used by the 'install_google_chrome' recipe to specify where to download the package from
default['myiis-cookbook']['chrome']['url'] = 'https://s3-eu-west-1.amazonaws.com/apop-bucket/GoogleChrome.msi'
# checksum obtained by running on a MAC: shasum -a 256 GoogleChrome.msi
default['myiis-cookbook']['chrome']['checksum'] = '465b6d4ec0cc855a96471a9739195e7a2effebc28bbf60a7bd4738c3556dec14'

