echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
echo 'export npm_config_userconfig=$HOME/.config/npmrc' >> ~/.bashrc
. ~/.bashrc
mkdir ~/.local
mkdir ~/node-latest-install
cd ~/node-latest-install
curl http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure --prefix=~/.local
make install
curl https://www.npmjs.org/install.sh | sh
