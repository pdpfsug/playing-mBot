-- Table of colors for the function turtle.brushDown()

colors = {
	"white",		-- 1  
	"grey",		-- 2
	"black",		-- 3
 	"red",		-- 4
	"yellow",		-- 5	
	"green",		-- 6
	"cyan",		-- 7
	"blue",		-- 8
	"magenta",		-- 9
	"orange",		--10 
	"violet",		--11
	"brown",		--12
	"pink",		--13
	"dark_grey",	--14
	"dark_green",	--15
	}

--Functions for the turtle
	-- Movement functions

turtle.forward = function(number)		
	local pos = {}
	if turtle.node.name == "logotest:turtle" then			
		if number == nil then number = 1 end
		for i = 1, number do
			pos = minetest.facedir_to_dir(turtle.node.param2)	-- this line checks the facing direction
			posAdd(pos, turtle.pos)						-- and adds the vector to the actual position
			if minetest.get_node(pos).name ~= "air" then		-- if there is a block, the turtle will not move
				print("FALSE")
				return false
			end
			minetest.remove_node(turtle.pos)				
			if turtle.brush ~= nil then 									-- if painting is activated, the turtle will create 
				minetest.set_node(turtle.pos, {name= "wool:"..turtle.color}) end	-- a block with the specificed color
   			posCopy1(turtle.pos, pos)
			minetest.set_node(turtle.pos, turtle.node)			
		end
		print("TRUE")
		return true
	else print("FALSE") return false end
end

turtle.back = function(number)
	local pos = {}
	local dir = turtle.node.param2 + 2
	if dir > 3 then dir = dir - 4 end
	if turtle.node.name == "logotest:turtle" then
		if number == nil then number = 1 end
		for i = 1, number do
			pos = minetest.facedir_to_dir(dir)
			posAdd(pos, turtle.pos)
			if minetest.get_node(pos).name ~= "air" then
				print("FALSE")
				return false
			end
			minetest.remove_node(turtle.pos)
			if turtle.brush ~= nil then 
				minetest.set_node(turtle.pos, {name= "wool:"..turtle.color}) end
   			posCopy1(turtle.pos, pos)
			minetest.set_node(turtle.pos, turtle.node)			
		end
		print("TRUE")
		return true
	else print("FALSE") return false end
end
	
turtle.up = function(number)
	local pos = {}
	if turtle.node.name == "logotest:turtle" then
		if number == nil then number = 1 end
		posCopy1(pos, turtle.pos)
		for i = 1, number do
			pos.y = pos.y + 1
			if minetest.get_node(pos).name ~= "air" then
				print("FALSE")
				return false
			end
			minetest.remove_node(turtle.pos)
			if turtle.brush ~= nil then 
				minetest.set_node(turtle.pos, {name= "wool:"..turtle.color}) end
   			turtle.pos.y = pos.y
			minetest.set_node(pos, turtle.node)
		end
		print("TRUE")
		return true
	else print("FALSE") return false end
end

turtle.down = function(number)
	local pos = {}
	if turtle.node.name == "logotest:turtle" then
		if number == nil then number = 1 end
		posCopy1(pos, turtle.pos)
		for i = 1, number do
			pos.y = pos.y - 1
			if minetest.get_node(pos).name ~= "air" then
				print("FALSE")
				return false
			end
			minetest.remove_node(turtle.pos)
			if turtle.brush ~= nil then 
				minetest.set_node(turtle.pos, {name= "wool:"..turtle.color}) end
			turtle.pos.y = pos.y
   			minetest.set_node(pos, turtle.node)
		end
		print("TRUE")
		return true
	else print("FALSE") return false end
end

turtle.turnLeft = function(number)
	if turtle.node.name == "logotest:turtle" then
		if number == nil then number = 1 end
		for i = 1, number do
			minetest.remove_node(turtle.pos)
   			turtle.node.param2 = turtle.node.param2 - 1
			if turtle.node.param2 == - 1 then turtle.node.param2 = turtle.node.param2 + 4 end
   			minetest.set_node(turtle.pos, turtle.node)
		end
		print("TRUE")
		return true
	else print("FALSE") return false end

end
turtle.turnRight = function(number)
	if turtle.node.name == "logotest:turtle" then
	if number == nil then number = 1 end
		for i = 1, number do
			minetest.remove_node(turtle.pos)
   			turtle.node.param2 = turtle.node.param2 + 1
			if turtle.node.param2 == 4 then 
				turtle.node.param2 = turtle.node.param2 - 4 
			end
   			minetest.set_node(turtle.pos, turtle.node)
		end
		print("TRUE")
		return true
	else print("FALSE") return false end
end

turtle.translate = function(x,y,z)			-- This function teleports the node to the specified position
	local pos = {}
	posCopy2(pos, x, y, z)
	if minetest.get_node(pos).name ~= "air" then
		print("FALSE")
		return false
	end
	minetest.remove_node(turtle.pos)
   	minetest.set_node(pos, turtle.node)
end

-- Digging functions

turtle.dig = function()
	local pos = minetest.facedir_to_dir(turtle.node.param2)
	if turtle.node.name == "logotest:turtle" then
		posAdd(pos, turtle.pos)
		minetest.dig_node(pos)
		print("TRUE")
		return true
	else print("FALSE") return false end
end

turtle.digUp = function()
	local pos = {}
	if turtle.node.name == "logotest:turtle" then
		posCopy1(pos, turtle.pos)
		pos.y = turtle.pos.y +1
		minetest.dig_node(pos)
		print("TRUE")
		return true
	else print("FALSE") return false end
end

turtle.digDown = function()
	local pos = {}
	if turtle.node.name == "logotest:turtle" then
		posCopy1(pos, turtle.pos)
		pos.y = pos.y - 1
		minetest.dig_node(pos)
		print("TRUE")
		return true
	else print("FALSE") return false end
end

-- Painting functions

turtle.brushDown = function(number)			-- this function starts the painting mode and selects the color
	if number > -1 and number < 16 then		-- from the list
		turtle.color = nil
		turtle.brush = 1
		turtle.color = colors[number]
	else print ("Select a color [1-15]") end
end

turtle.brushUp = function()				-- this function deactivates the painting mode
	turtle.brush = nil
end

-- Miscellaneous functions

turtle.load = function()					-- Runs the code
	print("Starting turtle " .. turtle.id)
	turtle.run = 1
	local program = loadfile(minetest.get_modpath("logotest") .. "\\turtlecode\\" .. turtle.id .. "\\program.lua")
	if pcall(program) then 
		print("Code successfully executed")
		turtle.run = nil
		return true
	else
		print("Unable to execute. The code has errors")
		turtle.run = nil
		return false
	end
end

function posCopy1(pos1, pos2)				-- Copies a position
	pos1.x = pos2.x
	pos1.y = pos2.y
	pos1.z = pos2.z
end

function posCopy2(pos, x, y, z)				-- Another function to copy 
	pos.x = x
	pos.y = y
	pos.z = z
end

function posAdd(pos1, pos2)				-- Adding function
	pos1.x = pos1.x + pos2.x
	pos1.y = pos1.y + pos2.y
	pos1.z = pos1.z + pos2.z
end