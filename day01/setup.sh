#!/bin/bash

set -eu

function check_command() {
    local com=$1
    type ${com} > /dev/null 2>&1
}

function check_package() {
    local pack=$1
    perl -M${pack} -e '' > /dev/null 2>&1
}

function install_package() {
    local pack=$1

    if ! check_package ${pack}; then
        cpanm ${pack}
    else
        echo "Note: Skip ${pack} install"
    fi

}

if ! check_command cpanm; then
    plenv install cpanm
else
    echo "Note: Skip cpanm install"
fi

install_package Ark
# Module::Setupのインストール時にCan't locate JSON.pm... のエラーが出たので
install_package JSON
# スケルトン作成用のモジュール
install_package Module::Setup

install_package LWP::Protocol::https
cpanm https://github.com/Konboi/p5-Module-Setup-Flavor-ArkDBIC/archive/master.tar.gz

# 下記の実行でインタラクティブに名前とメールアドレスを聞かれる
module-setup --init --flavor-class=Ark ark

# これが終わったらプロジェクトのルートフォルダで下記
# $ module-setup Jobeet
# $ cd Jobeet
# ($ cpanm Plack # ここまでの手順のどこかでインストールされているはず)
# $ plackup -r dev.psgi
#
# ブラウザから http://localhost:5000/ にアクセス
