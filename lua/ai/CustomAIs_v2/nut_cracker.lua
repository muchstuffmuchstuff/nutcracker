--[[
    File    :   /lua/AI/CustomAIs_v2/nut_cracker.lua
    Author  :   SoftNoob
    Summary :
        Lists AIs to be included into the lobby, see /lua/AI/CustomAIs_v2/SorianAI.lua for another example.
        Loaded in by /lua/ui/lobby/aitypes.lua, this loads all lua files in /lua/AI/CustomAIs_v2/
]]

AI = {
	Name = 'Nut Cracker AI',
	Version = '7',
	AIList = {
		{
			key = 'nut_cracker',
			name = '<LOC Nut_Cracker_0001>AI: Nut Cracker v1.3',
		},
	},
	CheatAIList = {
		{
			key = 'nut_crackercheat',
			name = '<LOC Nut_Cracker_0003>AIx: Nut Cracker v1.3',
		},
	},
}
