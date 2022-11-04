#!/bin/bash

cat << 'EOF' > /etc/needrestart/conf.d/99_restart.conf
$nrconf{kernelhints} = '0';
$nrconf{restart} = 'a';
EOF

apt update
apt -y upgrade

// 必要パッケージをインストール
apt install -y apt-transport-https ca-certificates curl software-properties-common

// Dockerの公式GPG keyを追加
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

// repository を追加
add-apt-repository "deb [arch=arm64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" --yes

// パッケージのアップデート
apt update

// docker をインストール
apt install -y docker-ce

apt -y install python3-pip unzip jq

apt install language-pack-ja -y
update-locale LANG=ja_JP.UTF-8
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip

rm setup.sh

reboot
