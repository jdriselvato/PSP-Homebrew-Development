-- Originally found here: https://glot.io/snippets/fz3f15yo3g

-- Making games on the PSP with LuaPlayer means anyone can read your source code. Sometimes that's great, sometimes it's not. 
-- Through your code into the SCRIPT_TO_OBFUSCATE = [[]] below and watch it output a new Obfuscate string.

--[[
-- For people who are new to obfuscating, here is a easy and simple way to obfuscate your scripts!

-- By M0_0Y on ROBLOX
]]

local throw_away = {}

local SCRIPT_TO_OBFUSCATE = [[
print(" YOUR SCRIPT HERE!! ")
]]

function GetBytes()
	for num = 1, #SCRIPT_TO_OBFUSCATE do
		throw_away[num] = string.byte(SCRIPT_TO_OBFUSCATE, num)
	end
end

function ConvertString()
	local string_buffer = "";
	for obj = 1, #throw_away do
		string_buffer = string_buffer .. "\\" .. throw_away[obj]
	end
	return string_buffer
end

function Obfuscate()
	GetBytes()
	local str = ConvertString()
	return print('loadstring("' .. str .. '")()')
end

Obfuscate()