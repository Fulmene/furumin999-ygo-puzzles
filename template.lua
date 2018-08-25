-- template.lua Used as a template for further puzzles

-- Template --

-- Basics
local ownLife = 8000
local oppLife = 8000
local oppName = "Adelaide"
local duelMode = DUEL_ATTACK_FIRST_TURN + DUEL_SIMPLE_AI
local masterRule = 4
local hint = { "Win this turn!" }

-- Field
-- adding template:
-- { id, position, zone number }
-- Field spell is SZone 5
-- Pendulums are PZone 0 and 1
-- (MR4) Extra monster zones are MZone 5 and 6
local oppSpellTrap = {}
local oppPendulum = {}
local oppMonster = {}
local ownMonster = {}
local ownPendulum = {}
local ownSpellTrap = {}

-- Other zones
-- Use only the card id to add
local oppHand = {}
local oppMainDeck = {}
local oppExtraDeck = {}
local oppFaceUpExtraDeck = {}
local oppGraveyard = {}
local oppBanished = {}

local ownBanished = {}
local ownGraveyard = {}
local ownFaceUpExtraDeck = {}
local ownExtraDeck = {}
local ownMainDeck = {}
local ownHand = {}

-- End template --

-- Constants
local PLAYER = 0
local OPPONENT = 1

-- Logic --

Debug.SetAIName(oppName)
Debug.ReloadFieldBegin(duelMode, masterRule)
Debug.SetPlayerInfo(PLAYER, ownLife, 0, 0)
Debug.SetPlayerInfo(OPPONENT, oppLife, 0, 0)

local fields = {
    { ownMonster, PLAYER, LOCATION_MZONE },
    { ownPendulum, PLAYER, LOCATION_PZONE },
    { ownSpellTrap, PLAYER, LOCATION_SZONE },
    { oppMonster, OPPONENT, LOCATION_MZONE },
    { oppPendulum, OPPONENT, LOCATION_PZONE },
    { oppSpellTrap, OPPONENT, LOCATION_SZONE }
}

for i, f in pairs(fields) do
    local cardList = f[1]
    local owner = f[2]
    local place = f[3]
    for j, c in pairs(cardList) do
        local id = c[1]
        local position = c[2]
        local zonenumber = c[3]
        Debug.AddCard(id, owner, owner, place, zonenumber, position)
    end
end

local zones = {
    { ownHand, PLAYER, LOCATION_HAND, POS_FACEDOWN },
    { ownMainDeck, PLAYER, LOCATION_DECK, POS_FACEDOWN },
    { ownExtraDeck, PLAYER, LOCATION_EXTRA, POS_FACEDOWN },
    { ownFaceUpExtraDeck, PLAYER, LOCATION_EXTRA, POS_FACEUP},
    { ownGraveyard, PLAYER, LOCATION_GRAVE, POS_FACEUP },
    { ownBanished, PLAYER, LOCATION_REMOVED, POS_FACEUP },
    { oppHand, OPPONENT, LOCATION_HAND, POS_FACEDOWN },
    { oppMainDeck, OPPONENT, LOCATION_DECK, POS_FACEDOWN },
    { oppExtraDeck, OPPONENT, LOCATION_EXTRA, POS_FACEDOWN },
    { oppFaceUpExtraDeck, OPPONENT, LOCATION_EXTRA, POS_FACEUP},
    { oppGraveyard, OPPONENT, LOCATION_GRAVE, POS_FACEUP },
    { oppBanished, OPPONENT, LOCATION_REMOVED, POS_FACEUP }
}

for i, z in pairs(zones) do
    local cardList = z[1]
    local owner = z[2]
    local place = z[3]
    local position = z[4]
    for j, id in pairs(cardList) do
        Debug.AddCard(id, owner, owner, place, 0, position)
    end
end

-- Special Effects

Debug.ReloadFieldEnd()

for i, h in pairs(hint) do
    Debug.ShowHint(h)
end

aux.BeginPuzzle()

-- End Logic --

