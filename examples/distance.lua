-- @example GPM Implementation strategy 'distance' and creating map.
-- Create a map based on the endpoints, and the cells.

-- import gpm
import("gpm")

-- create the CellularSpace
local csCenterspt = CellularSpace{
	file = filePath("communities.shp", "gpm"),
	geometry = true
}

local csLine = CellularSpace{
	file = filePath("roads.shp", "gpm"),
	geometry = true
}

local farms = CellularSpace{
	file = filePath("farms_cells.shp", "gpm"),
	geometry = true
}

-- create a Network with the distance of the end points to routes
local network = Network{
	target = csCenterspt,
	lines = csLine,
	weight = function(distance, cell)
		if cell.STATUS == "paved" then
			return distance / 5
		else
			return distance / 2
		end
	end,
	outside = function(distance) return distance * 2 end
}

-- creating a GPM with the distance of the entry points for the routes
GPM{
	network = network,
	origin = farms,
	distance = "distance",
	relation = "community",
	output = {
		id = "id1",
		distance = "distance"
	},
	maxDist = 2000
}

-- creating Map with values ​​GPM
map = Map{
	target = farms,
	select = "pointID",
	value = {1, 2, 3, 4},
	color = {"red", "blue", "green", "black"}
}
