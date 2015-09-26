# http://railsapps.github.io/installrubyonrails-ubuntu.html

sudo apt-get install curl
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
sudo apt-get install git
rvm get stable --autolibs=enable
rvm install ruby
/bin/bash --login
rvm --default use ruby-2.2.3
gem install bundler
gem install nokogiri
gem install rails

# install node before continuing 