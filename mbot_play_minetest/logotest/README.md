# logotest
A Minetest implementation using robotic Turtles focused on learning Logo lenguages.

How to install.
Copy the files into the mods folder of Minetest.

What does it include?

Moving functions: All the functions can optionally receive a number of actions to do, excepting translate. It needs a position (x,y,z)

turtle.forward
turtle.back 	
turtle.up 
turtle.down 
turtle.turnLeft
turtle.turnRight
turtle.translate

Digging functions: they delete the block in the especified position.

turtle.dig
turtle.digUp
turtle.digDown

Painting functions: to use brushDown you have to select a color from 1 to 15 from the list below. The turtle drops a wool block of the selected color.

turtle.brushDown
turtle.brushUp 

	"white",		-- 1  
	"grey",			-- 2
	"black",		-- 3
 	"red",			-- 4
	"yellow",		-- 5	
	"green",		-- 6
	"cyan",			-- 7
	"blue",			-- 8
	"magenta",		-- 9
	"orange",		--10 
	"violet",		--11
	"brown",		--12
	"pink",			--13
	"dark_grey",		--14
	"dark_green",		--15

Miscellaneous functions: functions to load a program from turtlecode, copy a position in diferent ways and adding positions.

turtle.load
function posCopy1(pos1, pos2)
function posCopy2(pos, x, y, z)
function posAdd(pos1, pos2)

How to use the turtles.

Once you put the turtle in the world, it create a folder in turtlecode folder of the mod. You can write the code in a file named program.lua or right-clicking on the turtle in the game.

 