-- Trickstar Exchange

-- Template --

-- Basics
local ownLife = 13400
local oppLife = 11600
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
local oppSpellTrap = {
}
local oppPendulum = {}
local oppMonster = {
    { 02857636, POS_FACEUP_ATTACK , 1 }, -- Troymare Phoenix
    { 65330383, POS_FACEUP_ATTACK , 2 }, -- Troymare Gryphon
    { 39064822, POS_FACEUP_ATTACK , 3 }, -- Troymare Goblin
}
local ownMonster = {
    { 86825114, POS_FACEUP_DEFENSE, 1 }, -- Nightshade
    { 61283655, POS_FACEUP_ATTACK , 2 }, -- Candina
    -- Iblee
}
local ownPendulum = {}
local ownSpellTrap = {
    { 74519184, POS_FACEDOWN, 1 }, -- Hand Destruction
    { 21076084, POS_FACEDOWN, 2 },  -- Reincarnation
}

-- Other zones
-- Use only the card id to add
local oppHand = {}
local oppMainDeck = {
    14558127, -- Urara
    35371948, -- Lightstage
    22159429, -- Magicorolla
    98700941, -- Lilybell
	73642296, -- Yashikiwarashi
    98169343, -- Carobein
    59438930, -- Usagi
}
local oppExtraDeck = {}
local oppFaceUpExtraDeck = {}
local oppGraveyard = {}
local oppBanished = {}

local ownBanished = {}
local ownGraveyard = {}
local ownFaceUpExtraDeck = {}
local ownExtraDeck = {
    41302052, -- Bellamadonna
    51011872, -- Bloody Mary
    77307161, -- Bloom
    86750474, -- Foxywitch
    94626871, -- Sweet Devil
    32448765, -- Holly Angel
}
local ownMainDeck = {
    99890852, -- Bouquet
    91505214, -- Narkissus
    63492244, -- Lightarena
    98169343, -- Carobein
}
local ownHand = {
    35199656, -- Manjushika
    35199656, -- Manjushika
    05556668, -- Exchange
    59604521, -- Shakunage
    98700941, -- Lilybell
    22219822, -- Mandrake
}

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
        Debug.AddCard(id, owner, owner, place, zonenumber, position, true)
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

-- Iblee
local iblee = Debug.AddCard(10158145, OPPONENT, PLAYER, LOCATION_MZONE, 3, POS_FACEUP_DEFENSE, true)
local control = Effect.CreateEffect(iblee)
control:SetType(EFFECT_TYPE_SINGLE)
control:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
control:SetRange(LOCATION_MZONE)
control:SetCode(EFFECT_CANNOT_CHANGE_CONTROL)
iblee:RegisterEffect(control)

-- End Special Effects

Debug.ReloadFieldEnd()

for i, h in pairs(hint) do
    Debug.ShowHint(h)
end

aux.BeginPuzzle()

-- End Logic --

