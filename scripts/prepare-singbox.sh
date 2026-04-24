#!/bin/bash
set -e
# 自动匹配架构
TARGET=$1
SING_VERSION="1.13.11"

# 架构映射
if [ "$TARGET" = "x86_64" ]; then
  SING_ARCH="amd64"
elif [ "$TARGET" = "armvirt-64" ] || [ "$TARGET" = "qualcommax_ipq807x" ]; then
  SING_ARCH="arm64"
else
  echo "不支持的架构"
  exit 1
fi

# 下载地址
URL="https://github.com/SagerNet/sing-box/releases/download/v${SING_VERSION}/sing-box-${SING_VERSION}-linux-${SING_ARCH}.tar.gz"

# 创建OpenWrt软件包
mkdir -p package/sing-box/files/usr/bin
cd package/sing-box

# 下载并解压预编译二进制
wget -q -O sing-box.tar.gz $URL
tar -zxf sing-box.tar.gz --strip-components=1
mv sing-box files/usr/bin/
chmod +x files/usr/bin/sing-box
rm -rf sing-box.tar.gz

# 生成OpenWrt Makefile
cat > Makefile << EOF
include \$(TOPDIR)/rules.mk
PKG_NAME:=sing-box
PKG_VERSION:=${SING_VERSION}
PKG_RELEASE:=1
PKG_LICENSE:=MIT

include \$(INCLUDE_DIR)/package.mk

define Package/sing-box
  SECTION:=net
  CATEGORY:=Network
  TITLE:=sing-box v1.13.11
  URL:=https://github.com/SagerNet/sing-box
endef

define Package/sing-box/description
  Universal proxy platform.
endef

define Build/Compile
endef

define Package/sing-box/install
	\$(INSTALL_DIR) \$(1)/usr/bin
	\$(INSTALL_BIN) ./files/usr/bin/sing-box \$(1)/usr/bin/
endef

\$(eval \$(call BuildPackage,sing-box))
EOF
