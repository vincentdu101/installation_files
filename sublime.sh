sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo apt-get update; sudo apt-get install -y sublime-text-installer

# assuming git installed
cd ~/.config/sublime-text-3/Packages
git clone https://github.com/SublimeCodeIntel/SublimeCodeIntel.git
git clone https://github.com/Xavura/CoffeeScript-Sublime-Plugin.git
git clone https://github.com/jaumefontal/SASS-Build-SublimeText2.git
git clone https://github.com/titoBouzout/SideBarEnhancements.git
git clone https://github.com/sergeche/emmet-sublime.git
git clone https://github.com/spadgos/sublime-jsdocs.git
