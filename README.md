# dotfiles

## 導入手順

```
 curl https://raw.githubusercontent.com/ohashi-yuki/dotfiles/master/setup.sh | sh
```

又は

```
git clone git@github.com:ohashi-yuki/dotfiles.git
cd dotfiles
make setup
```

curlの方がおすすめです。

以下、手動で設定が必要なもの。  

## solarized

iTerm2 > Preference > Profiles > Colors > solarized Darkを指定。

## Dock

システム環境設定 > Dock > 画面上の位置 > 左

## Caps Lock

Caps  Lockをコントロールキーで置き換えする。

システム環境設定 > キーボード > 修飾キー > Caps Lockキーをコントロールキーに変更

## キーの認識スピード

システム環境設定 > キーボード > キーのリピート/リピート認識までの時間  

速いと短いに設定する。

## 入力ソース切り替え

システム環境設定 > キーボード > ショートカット > 入力ソース > 前の入力ソースを選択  

⌘スペースに変更  


システム環境設定 > キーボード > ショートカット > Spotlight > Spotlight検索を表示  

チェックマークを外す


## Google IME

IMEはbrewでインストール済み。  
設定を行うのみ。  
https://qiita.com/hkusu/items/159e0ff07441ae2ec1fa

## コピペを書式合わせする

システム環境設定 > キーボード > ショートカット > アプリケーション

+ボタンでコマンドを追加する。  
メニュータイトル「ペーストしてスタイルを合わせる」。  
⌘+vを割り当てる。  

## ログイン時にアプリケーションを自動起動

https://pc-karuma.net/mac-app-startup/

## iTerm2でマウススクロールさせる

https://qiita.com/kawakami-kazuyoshi/items/83af0614beba840979fe

