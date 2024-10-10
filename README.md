# Electron Wrapper Next
---

Electron Wrapper Next用来包装任何一个网页到一个Electron应用。目前引用了应用商店的`com.electron`包作为依赖。
在结合本地npm缓存下,仅需数分钟即可产出任何一个网页封装之后的Electron二进制程序!

本项目是[Electron wrapper by Oyami-Srk](https://github.com/shirodeb/electron-wrapper)的正统精神传承，并承诺永久开源

## 使用方法

1. 新建一个构建目录,将`Electron Wrapper`项目`template`目录下的所有文件、目录复制到该构建目录中

2. 修改`build.sh`中的部分必填变量值：

```bash
NODE_PATH=""
ELECTRON_VERSION=""
export PACKAGE=""
export NAME=""
export NAME_CN=""
export URL="icon.png::icon-url"
export HOMEPAGE="" # wrapper content
```

必填变量解释:
| 变量 | 作用 |
| ------ | ------- |
| NODE_PATH | 设置Node.js二进制执行文件所在根目录 |
| ELECTRON_VERSION | 设置本次构建项目所使用的ELECTRON版本 |
| PACKAGE | 该应用构建后生成的包名 |
| NAME | 应用通用名称 |
| NAME_CN | 应用中文名称 |
| URL | 图标文件地址 |
| HOMEPAGE | 程序主页面地址 |

*备注:
 其中URL用来下载图标，icon-url应当替换成图标的地址，图标不能是ico格式。实际案例可参考recipes中的demo项目
 HOMEPAGE的值就是会被包装的网页的链接。
 你也可以在构建目录下放置任意js文件，以注入到加载后的网页里面。

3. 根据实际环境自定义`build.sh`中的部分操作：
可以根据实际环境条件及需求将`npm`替换为`cnpm`、`pnpm`等

4. 保存修改的内容后，在该目录下执行`build.sh`脚本即可开始构建，构建完成后将会在构建目录的`out`目录下生成可直接执行的完整二进制程序目录
