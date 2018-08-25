-- Judgment Day

-- Template --

-- Basics
local ownLife = 100
local oppLife = 10000
local oppName = "Adelaide"
local duelMode = DUEL_ATTACK_FIRST_TURN + DUEL_SIMPLE_AI
local masterRule = 3
local hint = { "Win this turn!" }

-- Field
-- adding template:
-- { id, position, zone number }
-- Field spell is SZone 5
-- Pendulums are PZone 0 and 1
-- (MR4) Extra monster zones are MZone 5 and 6
local oppSpellTrap = {
    { 30834988, POS_FACEUP, 2 }, -- All-Out Attacks
    { 44095762, POS_FACEDOWN, 1 }, -- Mirror Force
}
local oppPendulum = {
    { 37991342, POS_FACEUP, 1 }  -- Qliphort Genome
}
local oppMonster = {
    { 27279764, POS_FACEUP_ATTACK, 2 }  -- Apoqliphort Killer (will be added manually below)
}
local ownMonster = {
    { 37445295, POS_FACEDOWN_DEFENSE, 2 }  -- Shaddoll Falco
}
local ownPendulum = {}
local ownSpellTrap = {
    { 04904633, POS_FACEDOWN, 1 }, -- Shaddoll Core
    { 77505534, POS_FACEDOWN, 2 }  -- Sinister Shadow Games
}

-- Other zones
-- Use only the card id to add
local oppHand = {
    19665973  -- Battle Fader
}
local oppMainDeck = {
    40061558, -- Apoqliphort Kernel
    65518099  -- Qliphort Tool
}
local oppExtraDeck = {}
local oppFaceUpExtraDeck = {
    91907707, -- Qliphort Archive
    87588741, -- Qliphort Access
    64496451, -- Qliphort Disk
    51194046  -- Qliphort Assembla
}
local oppGraveyard = {
    90885155, -- Qliphort Shell
    13073850  -- Qliphort Alias
}
local oppBanished = {}

local ownBanished = {}
local ownGraveyard = {
    49885567, -- Cannahawk
    25857246, -- Necloth of Valkyrus
    44394295, -- Shaddoll Fusion
    88240999, -- Necloth of Decisive Arms
    20773176, -- Sephiraexa
    95401059  -- Sephiracore
}
local ownFaceUpExtraDeck = {
    58990362, -- Sephirashiugo
    22617205  -- Beelsephira
}
local ownExtraDeck = {
    94977269, -- Midrash
    48424886, -- Egrystal
    74009824, -- Wendigo
    19261966, -- Anomalilith
    56638325, -- Deltatheros
    18326736, -- Ptolemaeus
    26329679, -- Sacred Omega
    73964868, -- Sacred Pleiades
    19048328, -- Chouhou
    83755611, -- Shofuku
    43202238, -- Gaiza
    56655675, -- Ulti-Gaiapelio
    86274272, -- Ulti-Apelio
    48063985, -- Ulti-Cannahawk
    12678870  -- Ulti-Pettlephin
}
local ownMainDeck = {
    21495657, -- Sephirafuushi
    23166823, -- Sephirawendi
    58016954, -- Sephiranaga
    43434803, -- The Shallow Grave
    37445295, -- Shaddoll Falco
    13890468, -- Pettlephin
    32354768, -- Oracle of Sephira
    89463537  -- Necloth of Unicore
}
local ownHand = {
    96223501, -- Sephirathuban
    84388461, -- Sephirasaber
    97211663, -- Necloth Illusion
    52068432, -- Necloth of Trishula
    52846880, -- Necloth of Catastor
    57777714  -- Sephirampilica
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

-- End Special Effects

Debug.ReloadFieldEnd()

for i, h in pairs(hint) do
    Debug.ShowHint(h)
end

aux.BeginPuzzle()

-- End Logic --

