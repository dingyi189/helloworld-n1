local api = require "luci.model.cbi.passwall.api.api"
local appname = api.appname
local sys = api.sys
local net = require "luci.model.network".init()
local datatypes = api.datatypes

local nodes_table = {}
for k, e in ipairs(api.get_valid_nodes()) do
    if e.node_type == "normal" then
        nodes_table[#nodes_table + 1] = {
            id = e[".name"],
            obj = e,
            remarks = e["remark"]
        }
    end
end

m = Map(appname)

-- [[ Haproxy Settings ]]--
s = m:section(TypedSection, "global_haproxy")
s.anonymous = true

s:append(Template(appname .. "/haproxy/status"))

---- Balancing Enable
o = s:option(Flag, "balancing_enable", translate("Enable Load Balancing"))
o.rmempty = false
o.default = false

---- Console Username
o = s:option(Value, "console_user", translate("Console Username"))
o.default = ""
o:depends("balancing_enable", true)

---- Console Password
o = s:option(Value, "console_password", translate("Console Password"))
o.password = true
o.default = ""
o:depends("balancing_enable", true)

---- Console Port
o = s:option(Value, "console_port", translate("Console Port"))
o.default = "1188"
o:depends("balancing_enable", true)

-- [[ Balancing Settings ]]--
s = m:section(TypedSection, "haproxy_config", "")
s.template = "cbi/tblsection"
s.sortable = true
s.anonymous = true
s.addremove = true

s.create = function(e, t)
    TypedSection.create(e, api.gen_uuid())
end

s.remove = function(self, section)
    for k, v in pairs(self.children) do
        v.rmempty = true
        v.validate = nil
    end
    TypedSection.remove(self, section)
end

---- Enable
o = s:option(Flag, "enabled", translate("Enable"))
o.default = 1
o.rmempty = false
o.width = "8%"

---- Node Address
o = s:option(Value, "lbss", translate("Node Address"))
for k, v in pairs(nodes_table) do o:value(v.id, v.remarks) end
o.rmempty = false
o.width = "20%"
o.validate = function(self, value)
    if not value then return nil end
    local t = m:get(value) or nil
    if t and t[".type"] == "nodes" then
        return value
    end
    if datatypes.hostport(value) or datatypes.ip4addrport(value) then
        return value
    end
    if api.is_ipv6addrport(value) then
        return value
    end
    return nil, value
end

---- Haproxy Port
o = s:option(Value, "haproxy_port", translate("Haproxy Port"))
o.datatype = "port"
o.default = 1181
o.rmempty = false
o.width = "10%"

---- Node Weight
o = s:option(Value, "lbweight", translate("Node Weight"))
o.datatype = "uinteger"
o.default = 5
o.rmempty = false
o.width = "10%"

---- Export
o = s:option(ListValue, "export", translate("Export Of Multi WAN"))
o:value(0, translate("Auto"))
local wa = require "luci.tools.webadmin"
wa.cbi_add_networks(o)
o.default = 0
o.rmempty = false

---- Mode
o = s:option(ListValue, "backup", translate("Mode"))
o:value(0, translate("Primary"))
o:value(1, translate("Standby"))
o.rmempty = false

return m
