# this way is best if you want to stay up to date
# or submit patches to node or npm

mkdir ~/local
echo 'export PATH=$HOME/local/bin:$PATH' >> ~/.bashrc
. ~/.bashrc

# could also fork, and then clone your own fork instead of the official one

git clone git://github.com/joyent/node.git
cd node
./configure --prefix=~/local
make install
cd ..

git clone git://github.com/isaacs/npm.git
cd npm
make install # or `make link` for bleeding edge