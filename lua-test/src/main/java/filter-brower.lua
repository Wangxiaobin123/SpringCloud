---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by wangshengbin.
--- DateTime: 2021/9/6 下午5:50
---
local method = ngx.var.request_method
local uri = ngx.var.request_uri
if "POST" == method and "/server/api/access/login" == uri then
    ngx.req.read_body()
    local userdata = ngx.req.get_body_data()
    local json = require("cjson")
    local args = json.decode(userdata)
    local ip = ngx.var.remote_addr

    local agent = ngx.var.http_user_agent
    local woothee = require "resty.woothee"
    local r = woothee.parse(agent)

    local mysql = require "resty.mysql"
    local db, err = mysql:new()

    if not db then
        --ngx.say("failed to instantiate mysql: ", err)
        return
    end
    db:set_timeout(1000)

    -- or connect to a unix domain socket file listened
    -- by a mysql server:
    --     local ok, err, errcode, sqlstate =
    --           db:connect{
    --              path = "/path/to/mysql.sock",
    --              database = "ngx_test",
    --              user = "ngx_test",
    --              password = "ngx_test" }

    local ok = db:connect {
        host = "****",
        port = 3306,
        database = "bfd_mf_data_v4",
        user = "bfd_ibg_mf",
        password = "bfd_ibg_mf@168",
        charset = "utf8",
        max_packet_size = 1024 * 1024,
    }

    if not ok then
        --ngx.say("failed to connect: ", err, ": ", errcode, " ", sqlstate)
        return
    end
    --ngx.say("connected to mysql.")
    local insertSql = string.format("INSERT INTO `nginx_login_monitor` (`ip`,`account`,`password`,`agent`,`os`,`category`,`name`,`version`,`os_version`,`vendor`,`login_time`) VALUES(\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\',\'%s\')", ip, args.account, args.password, agent, r.os, r.category, r.name, r.version, r.os_version, r.vendor, ngx.time())
    local res, err = db:query(insertSql)
    if not res then
        --ngx.say("bad result: ", err, ": ", errcode, ": ", sqlstate, ".")
        db:close()
        return
    end
    --ngx.say(res.affected_rows, " rows inserted into table cats ", "(last insert id: ", res.insert_id, ")")
    ok, err = db:close()
    if not ok then
        --ngx.say("failed to close: ", err)
        return
    end
end
ngx.exec("@common_service")