local api = require "luci.model.cbi.passwall.api.api"
local appname = api.appname

m = Map(appname)

-- [[ App Settings ]]--
s = m:section(TypedSection, "global_app", translate("App Update"))
s.anonymous = true
s:append(Template(appname .. "/app_update/v2ray_version"))
s:append(Template(appname .. "/app_update/xray_version"))
s:append(Template(appname .. "/app_update/trojan_go_version"))

o = s:option(Value, "v2ray_file", translatef("%s App Path", "v2ray"))
o.default = "/usr/bin/v2ray"
o.rmempty = false

o = s:option(Value, "xray_file", translatef("%s App Path", "xray"))
o.default = "/usr/bin/xray"
o.rmempty = false

o = s:option(Value, "trojan_go_file", translatef("%s App Path", "trojan-go"))
o.default = "/usr/bin/trojan-go"
o.rmempty = false

return m
