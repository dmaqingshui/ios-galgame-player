# MyGalPlayer 启动包（阶段 1：空壳）

一个自己用的 iOS galgame 播放器的**起点工程**。当前版本只是一个空壳 App：
打开后显示 App 名、版本号和「游戏库（开发中）」占位字样。
它的作用只有一个——先证明整条链路能通：

**Windows 上改代码 → 推送到 GitHub → 云端 Mac 自动编译出 IPA → 用 SideStore 装到 iPhone 上打开。**

链路通了，后面的功能（导入解压、吉里吉里内核、RPG Maker）都重复这个循环往上叠。

## 目录里有什么

| 文件 | 作用 |
|---|---|
| `project.yml` | 工程定义（XcodeGen 格式）。仓库里**不保存** `.xcodeproj`，每次编译时在云端现生成，避免生成文件冲突 |
| `Sources/MyGalPlayer/` | App 源码（SwiftUI，就两个文件） |
| `.github/workflows/build.yml` | 云端编译流程：推送代码后自动编译、打包未签名 IPA |
| `VERSION` | 版本号文件（当前 0.1.0），IPA 文件名和产物名都从这里取 |
| `.gitignore` | 忽略编译产物和 Xcode 生成文件 |

- Bundle ID：`com.nikumao.galplayer`
- 显示名：MyGalPlayer
- 最低系统：iOS 17

## 第一步：把这个包传到 GitHub

### 方法 A：网页上传（推荐，不用装任何软件）

1. 打开 github.com，注册/登录账号。
2. 新建仓库：名字比如 `ios-gal-player`，**必须选 Public（公开）**——公开仓库的云端 Mac 编译免费不限量，私有仓库有分钟数限制。
3. 建好后在仓库页面点 **uploading an existing file**（或 Add file → Upload files）。
4. 把解压后的 `ios-gal-player-starter` 文件夹里的**全部内容**拖进上传框（包括 `.github` 文件夹和 `.gitignore` 这种以点开头的文件，别漏）。
   - 注意：网页拖拽有时会漏掉隐藏文件夹。传完后在仓库里检查：能看到 `.github/workflows/build.yml` 才算传全。
5. 点 Commit changes 提交。提交到 main 分支后，云端编译会自动开始。

### 方法 B：以后熟练了用 git 命令行

```bash
git init
git add .
git commit -m "阶段1: 空壳 App + CI"
git branch -M main
git remote add origin https://github.com/<你的用户名>/ios-gal-player.git
git push -u origin main
```

## 第二步：下载编译好的 IPA

1. 打开仓库页面上方的 **Actions** 标签。
2. 点最新一条 **Build unsigned IPA** 记录，等它跑完变绿勾（第一次大约几分钟）。
   - 如果是红叉：点进去看失败在哪个步骤，把日志最后几十行复制下来发给帮你写代码的 AI 工具修，你不用自己看懂。
3. 在成功记录页面下方 **Artifacts** 区域，下载 `MyGalPlayer-unsigned-0.1.0`，解压后得到 `.ipa` 文件。

> 这个 IPA 是**未签名**的，这是故意的：签名这一步交给 SideStore 在装机时完成，所以不需要苹果开发者账号，也不需要证书。

## 第三步：用 SideStore 装到 iPhone

前提：SideStore 已经按官方流程装好并完成配对、登录了你的 Apple ID。

1. 把 `.ipa` 文件传到手机（微信/QQ 文件传输、iCloud、数据线放进「文件」App 都行）。
2. 打开 SideStore → 底部「My Apps」→ 左上角「+」→ 选择这个 IPA 文件。
3. 等它安装完成，回到桌面打开 **MyGalPlayer**，能看到名字、版本号和「游戏库（开发中）」就是成功。
4. 免费 Apple ID 的签名 7 天过期，SideStore 会自动续签；只要它在后台刷新成功，App 就能一直用。偶尔打不开时，先打开 SideStore 手动刷新一次再装/再开。

## 版本号约定

- 版本号写在三个地方，必须一致：根目录 `VERSION` 文件、`project.yml` 里的 `MARKETING_VERSION`、App 内显示的字符串（`ContentView.swift` 里的 `appVersion`）。让 AI 改代码时提醒它三个一起改。
- 每完成一个阶段，中间位 +0.1（如 0.1.0 → 0.2.0）；阶段内修 bug 只改最后一位（如 0.1.0 → 0.1.1）。
- IPA 产物名带版本号，装新版前先看清版本，别装错旧包。

## 后续路线图（概要）

| 阶段 | 内容 | 验收标准 |
|---|---|---|
| 阶段 1（本包） | 空壳 App + 云端编译链路 | App 能装上、能打开、不闪退 |
| 阶段 2 | 壳子：游戏库界面、导入 zip 压缩包自动解压、游戏按目录管理、存档目录约定 | 导入一个游戏压缩包，解压文件数与电脑上一致 |
| 阶段 3 | 吉里吉里 / Kirikiri Z 内核（主线）：先评估 KrKr2-Next，不行换 Kirikiroid2 内核 | 目标游戏能从标题画面玩进第一章，CG、语音、存档正常 |
| 阶段 4 | RPG Maker MV/MZ：用 WebView 本地跑 HTML5 本体 | MZ 游戏能玩、存档杀进程重进不丢 |

规矩：一次只推进一个阶段，验收不过不跳段；每次修好都出一个新版本号的 IPA。

## 已知说明

- 本启动包在打包前只做过文件与语法层面的检查，**没有在真实 Mac 上跑过一遍编译**。第一次 Actions 运行时如果红叉，多半是工程生成或编译参数的小问题，把日志发给 AI 工具按报错改即可，这属于预期内的第一课。
- App 运行时完全离线：不联网、不统计、不拉远程配置。联网只发生在 GitHub 云端编译那一步。
