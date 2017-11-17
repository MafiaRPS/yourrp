--Copyright (C) 2017 Arno Zura ( https://www.gnu.org/licenses/gpl.txt )

GM.Name = "YourRP"
GM.ShortName = "YRP"	--Not longer then 4!
GM.Author = "D4KiR"
GM.Email = ""
GM.Discord = "https://discord.gg/sEgNZxg"
GM.Website = "youtube.com/c/D4KiR"
GM.Twitter = "twitter.com/D4KIR"
GM.Version = "0.9.2.4"
GM.VersionSort = "unstable"
GM.dedicated = "-"
GM.Help = ""

DeriveGamemode( "sandbox" )

function GM:Initialize()
	self.BaseClass.Initialize(self)
end

function GM:GetGameDescription()
	return GAMEMODE.Name
end

if SERVER then
	util.AddNetworkString( "getServerVersion" )
	net.Receive( "getServerVersion", function( len, ply )
		net.Start( "getServerVersion" )
			net.WriteString( GAMEMODE.Version )
			net.WriteBool( game.IsDedicated() )
		net.Send( ply )
	end)

  util.AddNetworkString( "getGamemodename" )
  local tmp = sql.Query( "SELECT value FROM yrp_general WHERE name = 'gamemodename'" )
	if tmp != false and tmp != nil then
	  GM.Name = tmp[1].value
	end
end

if CLIENT then
  timer.Simple( 1, function()
    net.Start( "getGamemodename" )
    net.SendToServer()
  end)

  net.Receive( "getGamemodename", function( len, ply )
    GAMEMODE.Name = net.ReadString()
  end)
end