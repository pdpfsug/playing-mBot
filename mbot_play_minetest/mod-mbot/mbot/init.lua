-- REST Arduino Interface
-- Luca Colciago @dottork
-- 13/12/2015
--
--

local www_box = {
	type = "regular"
}

local reset_meta = function(pos)
	minetest.get_meta(pos):set_string("formspec", "field[channel;Channel (not used);${channel}]".."field[ArduinoIPAddress;Serverino Robot (PORT or HOST:PORT);${ArduinoIPAddress}]")
end

local clearscreen = function(pos)
	local objects = minetest.get_objects_inside_radius(pos, 0.5)
	for _, o in ipairs(objects) do
		local o_entity = o:get_luaentity()
		if o_entity and o_entity.name == "mbot:text" then
			o:remove()
		end
	end
end

local on_digiline_receive = function(pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	print(setchan)

    local endpoint = meta:get_string("ArduinoIPAddress")
    i = string.find(endpoint, ":");
    host = endpoint:sub(0, i-1)
    port = endpoint:sub(i+1, string.len(endpoint))

	if setchan ~= channel then return end

	meta:set_string("text", msg)
	meta:set_string("infotext", msg)
	clearscreen(pos)
	if msg ~= "" then
		print("Arrivato un messaggio. Mando al BT")
		local answer = comandoz(msg)
        if answer ~= nil then
            if string.len(answer) > 11 then
                print("Arrivata una risposta diversa da un semplice ACK")
            end
		    digiline:receptor_send(pos, digiline.rules.default, "risposta", answer)
        end
	end
end

minetest.register_node("mbot:lcc", {
	drawtype = "nodebox",
	description = "Digiline ArduinoYUN Connection",
	inventory_image = "mbot.jpg",
	wield_image = "mbot.jpg",
	tiles = {"mbot.jpg"},

	paramtype = "light",
	sunlight_propagates = true,
        paramtype2 = "facedir",
	node_box = www_box,
	selection_box = www_box,
	groups = {choppy = 3, dig_immediate = 2},

	after_place_node = function (pos, placer, itemstack)
		local param2 = minetest.get_node(pos).param2
		if param2 == 0 or param2 == 1 then
			minetest.add_node(pos, {name = "mbot:lcc", param2 = 3})
		end
	end,

	on_construct = function(pos)
		reset_meta(pos)
	end,

	on_destruct = function(pos)
		clearscreen(pos)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
		end
                if (fields.channel) then
                        minetest.get_meta(pos):set_string("ArduinoIPAddress",fields.ArduinoIPAddress)
                end
	end,

	digiline = 
	{
		receptor = {},
		effector = {
			action = on_digiline_receive
		},
	},

	light_source = 6,
})

minetest.register_entity("mbot:text", {
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	visual = "upright_sprite",
	textures = {},

	on_activate = function(self)
		local meta = minetest.get_meta(self.object:getpos())
		local text = meta:get_string("text")
	end
})

-- Funzione da migliorare per inviare i dati via bluetooth

-- comandoz = function(c)
--         print("Ho ricevuto questi caratteri")
-- 	print(string.len(c))
-- 
-- 	
--         local wserial=io.open("/dev/rfcomm0","wb")
-- --        local wserial=io.open("/dev/ttyUSB0","w")
-- --	local wserial=io.open("datimbot","a")
--         if wserial ~= nil then
--            local rs = io.open("/dev/rfcomm0","rb")
-- 	   print(wserial)
-- 	   wserial:write(c)
-- 	   wserial:close()
--           
-- while chaine==nil do
--   chaine=rserial:read()
--   rserial:flush()
-- end
-- print("ricevuto")           
-- print(string.len(chaine))
--            rs:close()
-- 	   print("Ho spedito a BT!")
--         else 
--            print("Non spedito a BT, Errore apertura porta!")
--         end
-- 
-- end

comandoz = function(c)
    local socket = require("socket")
    host = host or "localhost"
    port = port or 4444
    print ("---- " .. host .. " port = " .. port)
    local sock = assert(socket.connect(host, port))
    sock:send(c)
    local answer, e = sock:receive('*l', 'ANSWER-')
    --answer = "ANSWER-pippo"
    if (e) then
        print("Errore " .. e)
    else
        print("Risposta " .. answer)
    end
    sock:close()
    return answer
end

post_string = function(s,purl)

    local http = require"socket.http"
    local ltn12 = require"ltn12"

    local reqbody = s   --"this is the body to be sent via post"
    local respbody = {} -- for the response body

    local result, respcode, respheaders, respstatus = http.request {
        method = "POST",
        url = purl,
        source = ltn12.source.string(reqbody),
        headers = {
            ["content-type"] = "text/plain",
            ["content-length"] = tostring(#reqbody)
        },
        sink = ltn12.sink.table(respbody)
    }
    -- get body as string by concatenating table filled by sink
    respbody = table.concat(respbody)
    return respbody

end

