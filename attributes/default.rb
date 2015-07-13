default['myiis-cookbook']['timezone']="UTC"

default['myiis-cookbook']['chrome']['url'] = 'https://s3-eu-west-1.amazonaws.com/apop-bucket/GoogleChrome.msi'
# checksum obtained by running on a MAC: shasum -a 256 GoogleChromeStandaloneEnterprise.msi
default['myiis-cookbook']['chrome']['checksum'] = '465b6d4ec0cc855a96471a9739195e7a2effebc28bbf60a7bd4738c3556dec14'

default['myiis-cookbook']['doc-root'] = 'c:/inetpub/wwwroot'
default['myiis-cookbook']['git-repo'] = 'https://github.com/alexpop/myhtml-app'
default['myiis-cookbook']['git-revision'] = 'master'

default['myiis-cookbook']['msdeploy']['zip'] = 'https://s3-eu-west-1.amazonaws.com/apop-bucket/all_sites-latest.zip'

