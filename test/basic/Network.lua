
return {
	Network = function(unitTest)
		local roads = CellularSpace{
			source = filePath("roads.shp", "gpm"),
			geometry = true
		}

		local communities = CellularSpace{
			source = filePath("communities.shp", "gpm"),
			geometry = true
		}

		local network = Network{
			lines = roads,
			target = communities,
			weight = function(distance, cell)
				if cell.CD_PAVIMEN == "pavimentada" then
					return d / 5
				else
					return d / 2
				end
			end,
			outside = function(distance, cell)
				return distance * 2
			end
		}

		unitTest:assertType(network, "Network")
	end
}

