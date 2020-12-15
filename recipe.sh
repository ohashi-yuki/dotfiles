brew install --cask dropbox
brew install --cask iterm2
brew install --cask mysqlworkbench
brew install --cask slack
brew install --cask caffeine
brew install --cask alfred
brew install --cask evernote
brew install --cask dash
brew install --cask hyperswitch
brew install --cask bettertouchtool
brew install --cask shiftit
brew install --cask vagrant
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack
brew install --cask lastpass
brew install --cask google-japanese-ime
brew install --cask google-chrome
brew install --cask phpstorm
brew install --cask postman
# Docker for Mac
brew install --cask docker
brew install jq
brew install mysql
# https://github.com/mrowa44/emojify
brew install emojify

brew install tig
brew install ansible
# ゴミ箱に削除
brew install trash
brew install go
brew tap peco/peco
brew install peco

brew install hub

brew install tree
brew install vim
brew install wget
brew install htop
brew install tmux
brew install ag
brew install gibo
# tmuxとMacクリップボードを同期できる
brew install reattach-to-user-namespace

brew tap homebrew/versions

# http://qiita.com/strsk/items/9151cef7e68f0746820d
brew tap motemen/ghq
brew install ghq

# iTermテンプレート
ghq get https://github.com/altercation/solarized.git

# .DS_Storeを作らない
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# composerをインストール
curl -sS https://getcomposer.org/installer | php -- --install-dir=~/bin
mv ~/bin/{composer.phar,composer}

# phpunitインストール
curl -sSL https://phar.phpunit.de/phpunit.phar > ~/bin/phpunit
chmod 775 ~/bin/phpunit

brew install npm
# TextLint
# @https://github.com/textlint/textlint
npm install textlint -g
# @see https://github.com/textlint-ja/textlint-rule-max-ten
npm install textlint-rule-max-ten -g
