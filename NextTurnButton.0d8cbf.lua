JOURNALISTS_MARKET_ZONE = Global.getVar('JOURNALISTS_MARKET_ZONE')
TOTAL_TURNS = Global.getVar('TOTAL_TURNS')

STAFF_MARKET_ZONE = Global.getVar('STAFF_MARKET_ZONE')
STAFF_DELETE_ZONE = Global.getVar('STAFF_DELETE_ZONE')
SUPPORT_MARKET_ZONE = Global.getVar('SUPPORT_MARKET_ZONE')
SUPPORT_DELETE_ZONE = Global.getVar('SUPPORT_DELETE_ZONE')

STAFF_DECK = Global.getVar('STAFF_DECK')
SUPPORT_DECK = Global.getVar('SUPPORT_DECK')
STORIES_DECK = Global.getVar('STORIES_DECK')

TURN_TOKEN = Global.getVar('TURN_TOKEN')
START_PLAYER_PAWN = Global.getVar('START_PLAYER_PAWN')

COLOR_DATA = Global.getTable('COLOR_DATA')
PLAYER_COUNT = 0
CURRENT_TURN = 0
ACTIVE_UPDATE = false

WEST_STORY_ZONES = Global.getTable('WEST_STORY_ZONES')
CENTRAL_STORY_ZONES = Global.getTable('CENTRAL_STORY_ZONES')
EAST_STORY_ZONES = Global.getTable('EAST_STORY_ZONES')


function nextTurn()
    if ACTIVE_UPDATE then
        return 1
    end
    ACTIVE_UPDATE = true
    CURRENT_TURN = CURRENT_TURN + 1
    PLAYER_COUNT = #getSeatedPlayers()
    PLAYER_COUNT = 4

    moveTurnToken()
    moveStartingPlayer()

    if CURRENT_TURN == TOTAL_TURNS then
        broadcastToAll("The game has ended. Score your newspapers!")
        -- destroyObject(self)
        return 1
    end

    moveMarket(STAFF_MARKET_ZONE, 'staff')
    moveMarket(SUPPORT_MARKET_ZONE, 'support')
    fillMarket(STAFF_DECK, -1.15)
    fillMarket(SUPPORT_DECK, 30.81)

    Global.call('dealJournalists')

    deleteStory(WEST_STORY_ZONES[1])
    deleteStory(CENTRAL_STORY_ZONES[1])
    deleteStory(EAST_STORY_ZONES[1])
    deleteStory(WEST_STORY_ZONES[2])
    deleteStory(CENTRAL_STORY_ZONES[2])
    deleteStory(EAST_STORY_ZONES[2])


    Wait.frames(nextTurnPhase2, 30)
end

function nextTurnPhase2()
    moveStorySet(WEST_STORY_ZONES)
    moveStorySet(CENTRAL_STORY_ZONES)
    moveStorySet(EAST_STORY_ZONES)

    deleteMarket(SUPPORT_DELETE_ZONE, 'support')
    deleteMarket(STAFF_DELETE_ZONE, 'staff')

    Wait.frames(nextTurnPhase3, 100)
end

function nextTurnPhase3()
    refillStories(WEST_STORY_ZONES)
    refillStories(CENTRAL_STORY_ZONES)
    refillStories(EAST_STORY_ZONES)

    ACTIVE_UPDATE = false
end


--
-- Healper Fucntions
--
function moveMarket(zoneGuid, tag)
    local zone = getObjectFromGUID(zoneGuid)
    for _, card in ipairs(zone.getObjects()) do
        if card.hasTag(tag) then
            card.setPositionSmooth(
                card.getPosition() + Vector(-3.87, 1, 0)
            )
        end
    end
end

function deleteMarket(zoneGuid, tag)
    local zone = getObjectFromGUID(zoneGuid)
    for _, card in ipairs(zone.getObjects()) do
        if card.hasTag(tag) then
            destroyObject(card)
        end
    end
end

function fillMarket(zone, y)
    local deck = getObjectFromGUID(zone)
    deck.takeObject({flip = true, position = {-7.88, 6.4, y}})
end

function moveTurnToken()
    local token = getObjectFromGUID(TURN_TOKEN)

    token.setPositionSmooth(
        token.getPosition() + Vector(1.166, 1, 0)
    )

    if CURRENT_TURN == 4 then
        destroyObject(token)
    end
end

function moveStartingPlayer(zone, y)
    local currentPlayer = Global.getVar('CURRENT_PLAYER') + 1
    local newStartingPlayer = (currentPlayer % PLAYER_COUNT) + 1
    Global.setVar('CURRENT_PLAYER', newStartingPlayer)
    local player = getSeatedPlayers()[newStartingPlayer]
    local pawn = getObjectFromGUID(START_PLAYER_PAWN)

    if player == 'Pink' then
        pawn.setPositionSmooth(getObjectFromGUID(COLOR_DATA.pink.start_area).getPosition() + Vector(0, 2, 1))
    end
    if player == 'Teal' then
        pawn.setPositionSmooth(getObjectFromGUID(COLOR_DATA.teal.start_area).getPosition() + Vector(0, 2, 1))
    end
    if player == 'Green' then
        pawn.setPositionSmooth(getObjectFromGUID(COLOR_DATA.green.start_area).getPosition() + Vector(0, 2, 1))
    end
    if player == 'Yellow' then
        pawn.setPositionSmooth(getObjectFromGUID(COLOR_DATA.yellow.start_area).getPosition() + Vector(0, 2, 1))
    end
end



function deleteStory(zoneTable)
    local zone = getObjectFromGUID(zoneTable)
    for _, card in ipairs(zone.getObjects()) do
        if card.hasTag('story') then
            destroyObject(card)
        end
    end
end

function moveStorySet(zoneTable)
    local storyMarket = {1,2,4,6}
    if PLAYER_COUNT == 3 then
        storyMarket = {1,2,3,4,6}
    end
    if PLAYER_COUNT == 4 then
        storyMarket = {1,2,3,4,5,6}
    end

    local toZone = getObjectFromGUID(zoneTable[1])

    moveStory(zoneTable, 1, storyMarket)
end


function moveStory(zoneTable, toIndex, storyMarket)
    local toZone = getObjectFromGUID(zoneTable[storyMarket[toIndex]])
    local fromIndex = toIndex+1
    local fromZone = getObjectFromGUID(zoneTable[storyMarket[fromIndex]])
    local fromCard = getFirstCard(fromZone.getObjects())

    while fromCard == nil and fromIndex < #storyMarket and fromZone ~= nil do
        fromIndex = fromIndex+1
        fromZone = getObjectFromGUID(zoneTable[storyMarket[fromIndex]])
        fromCard = getFirstCard(fromZone.getObjects())
    end

    if fromCard ~= nil then
        fromCard.setPositionSmooth(toZone.getPosition() + Vector(0, 1, 0))
    end

    if fromIndex < #storyMarket then
        Wait.frames(function()
            moveStory(zoneTable, toIndex+1, storyMarket)
        end, 15)
    end

end

function refillStories(zoneGuid)
    local deck = getObjectFromGUID(STORIES_DECK)
    for index, guid in ipairs(zoneGuid) do
        local zone = getObjectFromGUID(guid)
        local existingCard = getFirstCard(zone.getObjects())
        if (index == 1 or index == 2 or index == 4 or index == 6) and existingCard == nil then
            deck.takeObject({flip = true, position = zone.getPosition()  + Vector(0, 1, 0)})
        end
        if index == 3 and PLAYER_COUNT > 2 and existingCard == nil then
            deck.takeObject({flip = true, position = zone.getPosition()  + Vector(0, 1, 0)})
        end
        if index == 5 and PLAYER_COUNT > 3 and existingCard == nil then
            deck.takeObject({flip = true, position = zone.getPosition()  + Vector(0, 1, 0)})
        end
    end
end


--
-- Util Functions
--
function forEachPlayer(callback, params)
    for _, player in ipairs(getSeatedPlayers()) do
        if player == 'Teal' then
            callback(params.teal)
        end
        if player == 'Pink' then
            callback(params.pink)
        end
        if player == 'Green' then
            callback(params.green)
        end
        if player == 'Yellow' then
            callback(params.yellow)
        end
    end
end

function getFirstCard(t)
    for _, v in pairs(t) do
        if v.type == 'Card' then
           return v
        end
    end
end