#!/bin/bash

cat << 'EOF' > /etc/needrestart/conf.d/99_restart.conf
$nrconf{kernelhints} = '0';
$nrconf{restart} = 'a';
EOF

sudo apt update
sudo apt -y upgrade

// 必要パッケージをインストール
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

// Dockerの公式GPG keyを追加
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

// repository を追加
sudo add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" --yes

// パッケージのアップデート
sudo apt update

// docker をインストール
sudo apt install -y docker-ce

sudo apt -y install python3-pip

sudo apt install language-pack-ja -y
sudo update-locale LANG=ja_JP.UTF-8
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

sudo reboot
