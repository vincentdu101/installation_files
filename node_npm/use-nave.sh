# this way is really handy if you want to test things
# in different versions of node and use stable release
# versions of things.

# make a folder where you want to keep this stuff.

mkdir ~/.nave
cd ~/.nave
wget http://github.com/isaacs/nave/raw/master/nave.sh
sudo ln -s $PWD/nave.sh /usr/local/bin/nave

# now you can forget about that folder.
# you never have to go back in there.

# to use a version of node in a virtual environment
nave use 0.4.8

# to install npm in that virtualenv
curl https://www.npmjs.org/install.sh | sh

# do stuff...
npm install whatever etc

# return to non-nave-land
exit

# use a different version of node..
nave use 0.4.6
# etc...
