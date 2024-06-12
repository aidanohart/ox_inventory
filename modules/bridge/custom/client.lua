RegisterNetEvent("framework:character-disconnected", client.onLogout)

local function reorderGroups(groups)
    groups = groups or {}
    for group, info in pairs(groups) do
        groups[group] = info.rank
    end
    return groups
end

SetTimeout(500, function()
	local player = exports.framework.GetCharacterData()
    if not player then return end
    client.setPlayerData("groups", reorderGroups(player.groups))
end)

RegisterNetEvent("framework:load-character", function(character)
    client.setPlayerData("groups", reorderGroups(character.groups))
end)

RegisterNetEvent("ND:updateCharacter", function(character)
    client.setPlayerData("groups", reorderGroups(character.groups))
end)