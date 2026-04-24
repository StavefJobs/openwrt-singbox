# openwrt-singbox
openwrt add singbox plugins

# OpenWrt + sing-box 自动编译脚本
支持架构：x86_64 / armv8 / ipq807x
sing-box 版本：v1.13.11（预编译静态包，无Go环境）
OpenWrt 版本：25.12.2

## 使用方法
1. Fork 本仓库
2. 进入 GitHub Actions
3. 选择 Build OpenWrt with sing-box
4. 选择架构，点击 Run workflow
5. 等待编译完成，下载固件

## 验证安装
刷入固件后执行：
sing-box -v
