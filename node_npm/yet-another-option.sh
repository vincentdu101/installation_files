# install node wherever.
# use sudo even, it doesn't matter
# we're telling npm to install in a different place.

echo prefix = ~/local >> ~/.npmrc
curl https://www.npmjs.org/install.sh | sh
