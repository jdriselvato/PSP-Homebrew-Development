--[[	AoN Game Engine 
		Game Engine A* Algorithm File
		Ported to LUA By Roland Yonaba (a.k.a seanpaul223)
		seanpaul223[at]gmail[dot]com
		Written : 28/01/2010
		Latest Update: 25/07/2010
	]]

-- Some specifictions for develelopers
-- The Custom Node structure is defined here this way:
-- Struct node 
--	{ integer x; integer y;
--		integer G; the actual distance from the starting node
--		integer H; the heuristic distance to the final node
--		integer F; F = G+H
--	}

-------------------------------------------------------------	
--Basic Functions Needed by the main pathfinding function
-------------------------------------------------------------

--Looks for a node listed in a table of nodes.
--Returns true on success, plus the index where it was found.
--Otherwise returns false plus nil.
function isListed(list,node)
bool = false
	for k,v in pairs(list) do
		if (v.x==node.x) and (v.y==node.y) then return true,k end
	end
return false,nil
end

--Computes the heuristic distance from a node A to a node B
--Speed-Up Trick: Uses integer values to speed up computing
function distance(A,B)
return 10*(1+math.abs(A.x-B.x))+10*(1+math.abs(A.y-B.y))
end

--Tests if Node(x,y) is a valid Node on the map
--Returns true on false
function inMap(y,x,map)
	if y>0 and y<#map and x>0 and x<#map[y] then return true
	else return false
	end	
end

--Look around the finalNode for a free walkable Node
--returns its coordinates in the pathdinding grid when found
--Used when the finalNode is unwalkable
function getnext(map,finalNode,OBST,deep)
local y,x
	y = finalNode.y-deep
	for x = finalNode.x-deep,finalNode.x+deep do
		if inMap(y,x,map) and map[y][x]==0 then return y,x end
	end
	y=finalNode.y+deep
	for x = finalNode.x-deep,finalNode.x+deep do
		if inMap(y,x,map) and map[y][x]==0 then return y,x end
	end
	x = finalNode.x-deep
	for y = finalNode.y-deep,finalNode.y+deep do
		if inMap(y,x,map) and map[y][x]==0 then return y,x end
	end
	x=finalNode.x+deep
	for y = finalNode.y-deep,finalNode.y+deep do
		if inMap(y,x,map) and map[y][x]==0 then return y,x end
	end
end
	
	
--Looks for the nearest walkable node starting from the previously targetted one
--Max Deep will not go over 2.
function getNewFreeNode(map,finalNode,OBST,MAX_DEEP)
	local deep=1
	local newx,newy
	repeat
	newy,newx = getnext(map,finalNode,OBST,deep)
	deep=deep+1
		if (newx~=nil) and (newy~=nil) then break end
	until (deep >= MAX_DEEP)
	return newy,newx
end

-----------------------------------------------------
--Main Pathfinding functions
-----------------------------------------------------

--Searches for all nodes near the current one on a 2D map array
--Add them to the OpenList under some conditions
-- Speed up trick: sets the lower cost node each loop sow we do not need skimming through the open to find it
function addNode(map,currentNode,finalNode,CList,OList,OBST_VALUE)
--Gets the 2D map Limits
local limitX = #map[currentNode.y]
local limitY = #map
local lowerCostNode = currentNode 
	--Indices near nodes
	for y = currentNode.y-1,currentNode.y+1,1 do
		--Only focus on Y-indices valid on the map
		if (y>=1) and (y<=limitY) then
			for x=currentNode.x-1,currentNode.x+1,1 do
			--Only focus on X-indices valid on the map
				if (x>=1) and (x<=limitX) then
					--Assuming 1 is not a walkable location
					if (map[y][x]~=OBST_VALUE) then
					--We do not consider adjacent moves
					local left = (y==currentNode.y-1) and ((x==currentNode.x-1) or (x==currentNode.x+1))
					local right = (y==currentNode.y+1) and ((x==currentNode.x-1) or (x==currentNode.x+1))
						if not left and not right then
						--Computes a node to study
						local tmpNode = {y=y,x=x}
						tmpNode.G=10+currentNode.G
						tmpNode.H=distance(tmpNode,finalNode)
						tmpNode.F = tmpNode.G+tmpNode.H
						tmpNode.Parent ={x=currentNode.x,y=currentNode.y}
						--We do not consider nodes already stored Closed List
						local enclosed = isListed(CList,tmpNode)
							if not enclosed then
							--We update if necessay nodes already stored in Open List
							local opened,pos = isListed(OList,tmpNode)
								if opened then
									if (tmpNode.F<OList[pos].F) then
									OList[pos] = tmpNode;
									end
								else
							--else we add the studied node in OpenList
									if tmpNode.F<=lowerCostNode.F then
									lowerCostNode = tmpNode
									table.insert(OList,1,tmpNode) --The lower ost node is always at #1 in the OpenList
									else
									table.insert(OList,tmpNode)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end



--Main function, does all the stuff
--Returns a table of walkable locations when a valid path is found
--Otherwise returns nil
function pathfinding(map,startNode,finalNode,OBST_VALUE)
local path={} --will hold the path if found

--sets the starting node as the current one to study
local currentNode = {y= startNode.y, x= startNode.x,G=0,H=0,F=0,Parent = {y=startNode.y,x=startNode.x}}
local CList = {} --the Closed list
local OList = {} --The Open List

--we add the starting node in the Closed list
table.insert(CList,currentNode)

--Test if the dest node is walkable
--If not, tries to find a new Dest node near the previous one
local finalNode = finalNode
	if map[finalNode.y][finalNode.x]==OBST_VALUE then
	local y,x = getNewFreeNode(map,finalNode,OBST_VALUE,2)
		if (y~=nil) and (x~=nil) then
		finalNode.y,finalNode.x=y,x
		end
	end
	
	if map[finalNode.y][finalNode.x]~=OBST_VALUE then
	repeat
	addNode(map,currentNode,finalNode,CList,OList,OBST_VALUE) --Looks for near nodes
	--Finds the lower cost node : always the 1st item in the list
	local bestPos = next(OList)
		if bestPos then
		currentNode = OList[bestPos] --sets the lower cost node as the current one to study
		table.remove(OList,bestPos) --removes it from the OpenList
		table.insert(CList,currentNode) --adds it to the Closed List
		else CList = nil break  --stops computing if OpenList is empty.Meaning there is no valid path!
		end
	until (currentNode.x==finalNode.x) and (currentNode.y==finalNode.y)
	else
		return nil
	end
path=CList
return path,finalNode,startNode --returns path
end

--Tracks the path return by thepathfinding function
--Reoders the path from the starting node to the final node, otherwise nil
function track(p,finalNode,startNode)
	if p then
	local way={}
	
	local nxt={x=finalNode.x,y=finalNode.y}
	table.insert(way,1,nxt)
	local nxt=p[#p].Parent
	table.insert(way,1,nxt)
	
		repeat
		local bool,pos = isListed(p,nxt)
			if bool then
			nxt = p[pos].Parent
			table.insert(way,1,nxt)
			end
		until (nxt.y ==startNode.y and nxt.x == startNode.x)
		return way
	else return nil end
end



