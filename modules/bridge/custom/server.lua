local Inventory = require 'modules.inventory.server'

AddEventHandler("framework:character-disconnected", server.playerDropped)

local function reorderGroups(groups)
    groups = groups or {}
    for group, info in pairs(groups) do
        groups[group] = info.rank
    end
    return groups
end

local function setCharacterInventory(characterData)
	local player = {}

	player.source = characterData.source
	player.identifier = characterData.id
	player.name = characterData.firstname .. " " .. characterData.lastname
	player.groups = {'user'}
	player.sex = characterData.gender
	player.dateofbirth = characterData.dateofbirth

	data = json.decode(characterData.inventory)

    server.setPlayerInventory(player, data)
end

SetTimeout(500, function()
    characterData = exports.framework.GetCharacterData()
    for _, character in pairs(characterData) do
        setCharacterInventory(character)
    end
end)

AddEventHandler("framework:load-character", function(characterData)
    if not characterData then return end
	setCharacterInventory(characterData)
end)