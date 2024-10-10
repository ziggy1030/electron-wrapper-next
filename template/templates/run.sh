#!/bin/bash

cd /opt/apps/$PACKAGE/files
exec /opt/apps/com.electron/files/Electron/electron ./resources/app.asar "$@"
