
TOOL.Category = "YourRP - Admin"
TOOL.Name = "Routes"
TOOL.Command = nil
TOOL.ConfigName = ""

if CLIENT then
	language.Add( "tool.yrp_routes.name", "YourRP - Routes" )
	language.Add( "tool.yrp_routes.desc", "Left Click: Add Waypoint | Right Click: Remove Waypoint" )
	language.Add( "tool.yrp_routes.0", "Making ROUTES" )
end

function TOOL:LeftClick( trace )
	if SERVER then
		if IsValid( self:GetOwner() ) and trace.Hit then
			local sel_wayp = self:GetOwner():GetNW2Entity( "yrp_waypoint_selected", wayp )
			local wayp = YRPAddWaypoint( trace.HitPos, sel_wayp )
			if IsValid( wayp ) then
				self:GetOwner():SetNW2Entity( "yrp_waypoint_selected", wayp )
				print( "yrp_waypoint_selected", wayp)
			end
		end
	end
end
 
function TOOL:RightClick( trace )
	print( "NOTHING HERE: WIP" )
end

function TOOL.BuildCPanel(panel)
	panel:AddControl( "Header", {
		Text = "YourRP Route Tool",
		Description = "Left Click: Add Waypoint\nRight Click: Remove Waypoint"
	})
end

function YRPAddWaypoint( vec, sel_wayp )
	local wayp = ents.Create( "yrp_waypoint" )
	if IsValid( wayp ) then
		wayp:SetPos( vec )
		wayp:Spawn()

		if IsValid( sel_wayp ) then
			sel_wayp:SetNW2Entity( "yrp_waypoint_next", wayp )
		end
		print( "------------------------------" )
		print( "Added Waypoint" )

		return wayp
	else
		print( "FAIL" )
		return NULL
	end
end
