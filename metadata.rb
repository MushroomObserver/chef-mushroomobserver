name             'mushroomobserver'
maintainer       'Mushroom Observer'
maintainer_email 'nathan@mushroomobserver.org'
license          'MIT'
description      'Installs/Configures mushroomobserver'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

%w{ rvm mysql database build-essential sudo }.each do |cb|
  depends cb
end
