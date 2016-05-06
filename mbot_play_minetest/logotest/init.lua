--Global variable for the functions and data

turtle = {}		

-- Api file

dofile(minetest.get_modpath("logotest").."/api.lua")

minetest.register_on_player_receive_fields(function(player, formname, fields) 		-- Right menu for the turtle node
	if fields.instructions ~= nil then	
		local f = assert(io.open(minetest.get_modpath("logotest") .. 
					"\\turtlecode\\" .. turtle.id .. "\\program.lua","w"))
		assert(f:write(fields.instructions))
		assert(f:close())
		if turtle.load() == false then 
			os.execute("del /Q " .. minetest.get_modpath("logotest") .. "\\turtlecode\\" .. turtle.id .. "\\*.*")
			end
	end
	turtle.brush = nil
	turtle.id = nil
end)

minetest.register_craft({					-- Recipe for the node
	output = 'logotest:turtle',
	recipe = {
		{'default:wood','default:wood','default:wood'},
		{'default:wood','','default:wood'},
		{'default:wood','','default:wood'},
	}
})
	
minetest.register_node("logotest:turtle", {		-- The turtle node
	description = "Turtle",
	tiles = {"logotest_turtle_1.png",
		    "logotest_turtle_2.png",
		    "logotest_turtle_3.png",
		    "logotest_turtle_4.png",
		    "logotest_turtle_5.png",
		    "logotest_turtle_6.png"},
	groups = {cracky=3},
	paramtype2 = "facedir",
	on_construct = function (pos)					-- Putting the block creates the directory turtle id.  
		local meta = minetest.get_meta(pos)			-- The turle id will be obtained from the local time.
		if turtle.id == nil then
			turtle.id = os.clock()				
			os.execute("mkdir " .. minetest.get_modpath("logotest") .. "\\turtlecode\\" .. turtle.id)
			print("Placed turtle " .. turtle.id)
			end
		meta:set_string("id", minetest.serialize(turtle.id))
		if turtle.run == nil then turtle.id = nil end
		end
	,
	on_rightclick = function(pos, node, puncher, pointed_thing)	-- Right click shows a menu or activate the turtle with the code
		local meta = minetest.get_meta(pos)					-- in the turtle id folder.
		turtle.id = minetest.deserialize(meta:get_string("id"))	
		turtle.pos = pos
		turtle.node = node
		if file_exists(minetest.get_modpath("logotest") .. "\\turtlecode\\" .. turtle.id .. "\\program.lua","r") then
			turtle.load()
			turtle.id = nil
		else	minetest.show_formspec("singleplayer","instructions", 
			"size[10,5]" ..
			"textarea[0.5,0;9.5,5;instructions;;]" ..
			"button_exit[3.5,4.5;3,1;;Send]")
			end
		end
	,
	on_destruct = function(pos)				-- When you destroy the turtle node, the turtle id folder and the code file will be 
		if turtle.id == nil then				-- erased.
			local meta = minetest.get_meta(pos)
			local code = minetest.deserialize(meta:get_string("id"))
			os.execute("del /Q " .. minetest.get_modpath("logotest") .. "\\turtlecode\\" .. code .. "\\*.*")
			os.execute("rmdir " .. minetest.get_modpath("logotest") .. "\\turtlecode\\" .. code)
			end
		end
})