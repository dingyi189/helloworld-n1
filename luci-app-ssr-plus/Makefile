include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ssr-plus
PKG_VERSION:=1.0
PKG_RELEASE:=68

PKG_CONFIG_DEPENDS:= \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_NONE_V2RAY \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_V2ray \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Xray \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ChinaDNS_NG \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_NONE_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_NONE_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Server \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Simple_Obfs \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_V2ray_Plugin \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client \
	CONFIG_PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server \
	
LUCI_TITLE:=SS/SSR/V2Ray/Xray/Socks5/Tun LuCI interface
LUCI_PKGARCH:=all
LUCI_DEPENDS:= \
	+libustream-openssl \
	+coreutils +coreutils-base64 +dns2socks +dns2tcp +dnsmasq-full +@PACKAGE_dnsmasq_full_ipset +ipset +kmod-ipt-nat \
	+ip-full +iptables +iptables-mod-tproxy +lua +lua-neturl +libuci-lua +microsocks \
	+tcping +resolveip +shadowsocksr-libev-ssr-check +uclient-fetch \
	+PACKAGE_$(PKG_NAME)_INCLUDE_V2ray:curl \
	+PACKAGE_$(PKG_NAME)_INCLUDE_V2ray:v2ray-core \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Xray:curl \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Xray:xray-core \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ChinaDNS_NG:chinadns-ng \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client:shadowsocks-libev-ss-local \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client:shadowsocks-libev-ss-redir \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server:shadowsocks-libev-ss-server \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Client:shadowsocks-rust-sslocal \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Server:shadowsocks-rust-ssserver \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Simple_Obfs:simple-obfs \
	+PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_V2ray_Plugin:v2ray-plugin \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client:shadowsocksr-libev-ssr-local \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client:shadowsocksr-libev-ssr-redir \
	+PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server:shadowsocksr-libev-ssr-server \
	
define Package/$(PKG_NAME)/config
select PACKAGE_luci-lib-ipkg if PACKAGE_$(PKG_NAME)

choice
	prompt "Shadowsocks Client Selection"
	default PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Client if aarch64
	default PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client

	config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_NONE_Client
	bool "None"

	config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Client
	bool "Shadowsocks-libev"

	config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Client
	bool "Shadowsocks-rust"
	depends on aarch64||arm||i386||mips||mipsel||x86_64
	depends on !(TARGET_x86_geode||TARGET_x86_legacy)
endchoice

choice
	prompt "Shadowsocks Server Selection"
	default PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Server if aarch64
	default PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server if i386||x86_64||arm
	default PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_NONE_Server

	config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_NONE_Server
	bool "None"

	config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Libev_Server
	bool "Shadowsocks-libev"

	config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Rust_Server
	bool "Shadowsocks-rust"
	depends on aarch64||arm||i386||mips||mipsel||x86_64
	depends on !(TARGET_x86_geode||TARGET_x86_legacy)
endchoice

choice
	prompt "V2ray-core Selection"
	default PACKAGE_$(PKG_NAME)_INCLUDE_Xray if aarch64||arm||i386||x86_64
	default PACKAGE_$(PKG_NAME)_INCLUDE_NONE_V2RAY

	config PACKAGE_$(PKG_NAME)_INCLUDE_NONE_V2RAY
	bool "None"

	config PACKAGE_$(PKG_NAME)_INCLUDE_V2ray
	bool "V2ray-core"

	config PACKAGE_$(PKG_NAME)_INCLUDE_Xray
	bool "Xray-core"
endchoice

config PACKAGE_$(PKG_NAME)_INCLUDE_ChinaDNS_NG
	bool "Include ChinaDNS-NG"
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_Simple_Obfs
	bool "Include Shadowsocks Simple Obfs Plugin"
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_Shadowsocks_V2ray_Plugin
	bool "Include Shadowsocks V2ray Plugin"
	default n

config PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Client
	bool "Include ShadowsocksR Libev Client"
	default y

config PACKAGE_$(PKG_NAME)_INCLUDE_ShadowsocksR_Libev_Server
	bool "Include ShadowsocksR Libev Server"
	default n
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/shadowsocksr
/etc/ssrplus/
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
