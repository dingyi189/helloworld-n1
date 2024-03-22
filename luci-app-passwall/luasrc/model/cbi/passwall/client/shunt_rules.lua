local api = require "luci.model.cbi.passwall.api.api"
local appname = api.appname
local datatypes = api.datatypes

m = Map(appname, translate("Shunt Rule"))
m.redirect = api.url()

s = m:section(NamedSection, arg[1], "shunt_rules", "")
s.addremove = false
s.dynamic = false

remarks = s:option(Value, "remarks", translate("Remarks"))
remarks.default = arg[1]
remarks.rmempty = false

protocol = s:option(MultiValue, "protocol", translate("Protocol"))
protocol:value("http")
protocol:value("tls")
protocol:value("bt")

domain_list = s:option(TextValue, "domain_list", translate("Domain"))
domain_list.rows = 10
domain_list.wrap = "off"
domain_list.validate = function(self, value)
    local hosts= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(hosts, w) end)
    for index, host in ipairs(hosts) do
        local flag = 1
        local tmp_host = host
        if host:find("regexp:") and host:find("regexp:") == 1 then
            flag = 0
        elseif host:find("domain:.") and host:find("domain:.") == 1 then
            tmp_host = host:gsub("domain:", "")
        elseif host:find("full:.") and host:find("full:.") == 1 then
            tmp_host = host:gsub("full:", "")
        elseif host:find("geosite:") and host:find("geosite:") == 1 then
            flag = 0
        elseif host:find("ext:") and host:find("ext:") == 1 then
            flag = 0
        end
        if flag == 1 then
            if not datatypes.hostname(tmp_host) then
                return nil, tmp_host .. " " .. translate("Not valid domain name, please re-enter!")
            end
        end
    end
    return value
end
ip_list = s:option(TextValue, "ip_list", translate("IP adress"))
ip_list.rows = 10
ip_list.wrap = "off"
ip_list.validate = function(self, value)
    local ipmasks= {}
    string.gsub(value, '[^' .. "\r\n" .. ']+', function(w) table.insert(ipmasks, w) end)
    for index, ipmask in ipairs(ipmasks) do
        if ipmask:find("geoip:") and ipmask:find("geoip:") == 1 then
        elseif ipmask:find("ext:") and ipmask:find("ext:") == 1 then
        else
            if not (datatypes.ipmask4(ipmask) or datatypes.ipmask6(ipmask)) then
                return nil, ipmask .. " " .. translate("Not valid IP format, please re-enter!")
            end
        end
    end
    return value
end

return m
