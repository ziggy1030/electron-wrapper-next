#!/bin/bash

TOOLS_VERSION="1.0.3"

set -x

SELF=$(readlink -f "$0")
BUILD_DIR=${SELF%/*}
SRC_DIR=$BUILD_DIR
APP_DIR=$BUILD_DIR

## Writeable Envs
NODE_PATH="/media/ziggy/Data/share_libs/amd64/nodejs/node18/bin"
export PATH="$NODE_PATH:$PATH"
export ELECTRON_VERSION="28.3.3"

export PACKAGE="org.deepin.games-demo"
export NAME="Games Demo"
export NAME_CN="Games Demo"
export VERSION="$ELECTRON_VERSION"
export ARCH="all"
export URL="icon.png::https://img.poki-cdn.com/cdn-cgi/image/quality=78,width=40,height=40,fit=cover,f=auto/2d6442164d27e469ce5d8b6db7864631.png"
export DO_NOT_UNARCHIVE=1
# autostart,notification,trayicon,clipboard,account,bluetooth,camera,audio_record,installed_apps
export REQUIRED_PERMISSIONS=""

export HOMEPAGE="https://poki.com/zh/g/level-devil"
# export DEPENDS="libgconf-2-4, libgtk-3-0, libnotify4, libnss3, libxtst6, xdg-utils, libatspi2.0-0, libdrm2, libgbm1, libxcb-dri3-0, kde-cli-tools | kde-runtime | trash-cli | libglib2.0-bin | gvfs-bin, deepin-elf-verify"
export DEPENDS="com.electron"
export BUILD_DEPENDS="npm"
export SECTION="misc"
export PROVIDE=""
export DESC1="Electron wrapper for $HOMEPAGE"
export DESC2=""

#export INGREDIENTS=(nodejs)

## Generated
    cp "$BUILD_DIR/templates/index.js" "$SRC_DIR/index.js"
    mkdir -p $APP_DIR/files/
    cp "$BUILD_DIR/templates/run.sh" "$APP_DIR/files/run.sh"
    cat "$BUILD_DIR/templates/package.json" | envsubst >"$SRC_DIR/package.json"

    pushd "$SRC_DIR"

 #   export ELECTRON_MIRROR=https://registry.npmmirror.com/
    cnpm install 
    cnpm run build
    mkdir -p $APP_DIR/files/resources/
    cp -RT out/linux-unpacked/resources $APP_DIR/files/resources
    mkdir -p "$APP_DIR/files/userscripts"
    cp "$BUILD_DIR"/*.js "$APP_DIR/files/userscripts/"

    popd

    rm -rf $APP_DIR/entries/icons/hicolor/**/apps/icon.png

    mkdir -p "$APP_DIR/entries/applications"
    cat <<EOF >$APP_DIR/entries/applications/$PACKAGE.desktop
[Desktop Entry]
Name=$NAME
Name[zh_CN]=$NAME_CN
Exec=env PACKAGE=$PACKAGE /opt/apps/$PACKAGE/files/run.sh %U
Terminal=false
Type=Application
Icon=$PACKAGE
StartupWMClass=$PACKAGE
Categories=Games;
EOF

