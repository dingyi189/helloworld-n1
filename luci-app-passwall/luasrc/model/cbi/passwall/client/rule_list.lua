local api = require "luci.model.cbi.passwall.api.api"
local appname = api.appname
local fs = api.fs
local sys = api.sys
local datatypes = api.datatypes
local path = string.format("/usr/share/%s/rules/", appname)
local route_hosts_path = "/etc/"

m = Map(appname)

-- [[ Rule List Settings ]]--
s = m:section(TypedSection, "global_rules")
s.anonymous = true

s:tab("direct_list", translate("Direct List"))
s:tab("proxy_list", translate("Proxy List"))
s:tab("block_list", translate("Block List"))
s:tab("lan_ip_list", translate("Lan IP List"))
s:tab("route_hosts", translate("Route Hosts"))

---- Direct Hosts
local direct_host = path .. "direct_host"
o = s:taboption("direct_list", TextValue, "direct_host", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(direct_host) or ""
end
o.write = function(self, section, value)
    fs.writefile(direct_host, value:gsub("\r\n", "\n"))
    sys.call("rm -rf /tmp/etc/passwall_tmp/dns_*")
end
o.remove = function(self, section, value)
    fs.writefile(direct_host, "")
    sys.call("rm -rf /tmp/etc/passwall_tmp/dns_*")
end
o.validate = function(self, value)
    local hosts= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(hosts, w) end)
    for index, host in ipairs(hosts) do
        if host:find("#") and host:find("#") == 1 then
            return value
        end
        if not datatypes.hostname(host) then
            return nil, host .. " " .. translate("Not valid domain name, please re-enter!")
        end
    end
    return value
end

---- Direct IP
local direct_ip = path .. "direct_ip"
o = s:taboption("direct_list", TextValue, "direct_ip", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(direct_ip) or ""
end
o.write = function(self, section, value)
    fs.writefile(direct_ip, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(direct_ip, "")
end
o.validate = function(self, value)
    local ipmasks= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(ipmasks, w) end)
    for index, ipmask in ipairs(ipmasks) do
        if ipmask:find("#") and ipmask:find("#") == 1 then
            return value
        end
        if not ( datatypes.ipmask4(ipmask) or datatypes.ipmask6(ipmask) ) then
            return nil, ipmask .. " " .. translate("Not valid IP format, please re-enter!")
        end
    end
    return value
end

---- Proxy Hosts
local proxy_host = path .. "proxy_host"
o = s:taboption("proxy_list", TextValue, "proxy_host", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(proxy_host) or ""
end
o.write = function(self, section, value)
    fs.writefile(proxy_host, value:gsub("\r\n", "\n"))
    sys.call("rm -rf /tmp/etc/passwall_tmp/dns_*")
end
o.remove = function(self, section, value)
    fs.writefile(proxy_host, "")
    sys.call("rm -rf /tmp/etc/passwall_tmp/dns_*")
end
o.validate = function(self, value)
    local hosts= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(hosts, w) end)
    for index, host in ipairs(hosts) do
        if host:find("#") and host:find("#") == 1  then
            return value
        end
        if not datatypes.hostname(host) then
            return nil, host .. " " .. translate("Not valid domain name, please re-enter!")
        end
    end
    return value
end

---- Proxy IP
local proxy_ip = path .. "proxy_ip"
o = s:taboption("proxy_list", TextValue, "proxy_ip", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(proxy_ip) or ""
end
o.write = function(self, section, value)
    fs.writefile(proxy_ip, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(proxy_ip, "")
end
o.validate = function(self, value)
    local ipmasks= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(ipmasks, w) end)
    for index, ipmask in ipairs(ipmasks) do
        if ipmask:find("#") and ipmask:find("#") == 1 then
            return value
        end
        if not ( datatypes.ipmask4(ipmask) or datatypes.ipmask6(ipmask) ) then
            return nil, ipmask .. " " .. translate("Not valid IP format, please re-enter!")
        end
    end
    return value
end

---- Block Hosts
local block_host = path .. "block_host"
o = s:taboption("block_list", TextValue, "block_host", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(block_host) or ""
end
o.write = function(self, section, value)
    fs.writefile(block_host, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(block_host, "")
end
o.validate = function(self, value)
    local hosts= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(hosts, w) end)
    for index, host in ipairs(hosts) do
        if host:find("#") and host:find("#") == 1 then
            return value
        end
        if not datatypes.hostname(host) then
            return nil, host .. " " .. translate("Not valid domain name, please re-enter!")
        end
    end
    return value
end

---- Block IP
local block_ip = path .. "block_ip"
o = s:taboption("block_list", TextValue, "block_ip", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(block_ip) or ""
end
o.write = function(self, section, value)
    fs.writefile(block_ip, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(block_ip, "")
end
o.validate = function(self, value)
    local ipmasks= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(ipmasks, w) end)
    for index, ipmask in ipairs(ipmasks) do
        if ipmask:find("#") and ipmask:find("#") == 1 then
            return value
        end
        if not ( datatypes.ipmask4(ipmask) or datatypes.ipmask6(ipmask) ) then
            return nil, ipmask .. " " .. translate("Not valid IP format, please re-enter!")
        end
    end
    return value
end

---- Lan IPv4
local lanlist_ipv4 = path .. "lanlist_ipv4"
o = s:taboption("lan_ip_list", TextValue, "lanlist_ipv4", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(lanlist_ipv4) or ""
end
o.write = function(self, section, value)
    fs.writefile(lanlist_ipv4, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(lanlist_ipv4, "")
end
o.validate = function(self, value)
    local ipmasks= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(ipmasks, w) end)
    for index, ipmask in ipairs(ipmasks) do
        if ipmask:find("#") and ipmask:find("#") == 1 then
            return value
        end
        if not datatypes.ipmask4(ipmask) then
            return nil, ipmask .. " " .. translate("Not valid IPv4 format, please re-enter!")
        end
    end
    return value
end

---- Lan IPv6
local lanlist_ipv6 = path .. "lanlist_ipv6"
o = s:taboption("lan_ip_list", TextValue, "lanlist_ipv6", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(lanlist_ipv6) or ""
end
o.write = function(self, section, value)
    fs.writefile(lanlist_ipv6, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(lanlist_ipv6, "")
end
o.validate = function(self, value)
    local ipmasks= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(ipmasks, w) end)
    for index, ipmask in ipairs(ipmasks) do
        if ipmask:find("#") and ipmask:find("#") == 1 then
            return value
        end
        if not datatypes.ipmask6(ipmask) then
            return nil, ipmask .. " " .. translate("Not valid IPv6 format, please re-enter!")
        end
    end
    return value
end

---- Route Hosts
local hosts = route_hosts_path .. "hosts"
o = s:taboption("route_hosts", TextValue, "hosts", "", translate(""))
o.rows = 15
o.wrap = "off"
o.cfgvalue = function(self, section)
    return fs.readfile(hosts) or ""
end
o.write = function(self, section, value)
    fs.writefile(hosts, value:gsub("\r\n", "\n"))
end
o.remove = function(self, section, value)
    fs.writefile(hosts, "")
end

return m
