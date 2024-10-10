const { app, BrowserWindow } = require('electron');
const package = require('./package.json');
const fs = require('fs');

const createWindow = () => {
    const isChinese = ['zh', 'zh-CN', 'zh-HK', 'zh-TW'].indexOf(app.getLocale()) >= 0;
    const win = new BrowserWindow({
        autoHideMenuBar: true,
        icon: './icon.png',
        title: isChinese ? package.title_cn : package.title
    });
    win.loadURL(package.homepage);
    win.webContents.on('did-finish-load', function () {
        if (fs.existsSync("./userscripts") && fs.statSync("./userscripts").isDirectory()) {
            fs.readdirSync("./userscripts").forEach(path => {
                const inject_source_code = fs.readFileSync(`./userscripts/${path}`).toString();
                win.webContents.executeJavaScript(inject_source_code);
            });
        }
    });
};

// 应用程序准备好后加载窗口
app.whenReady().then(() => {
    createWindow();

    app.on('activate', () => {
        if (BrowserWindow.getAllWindows().length === 0) createWindow();
    });
});

// 窗口关闭后退出应用程序
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit();
});

// 设置WM_CLASS
app.setName(package.name);