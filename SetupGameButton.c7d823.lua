JOURNALISTS_DECK = Global.getVar('JOURNALISTS_DECK')
STAFF_DECK = Global.getVar('STAFF_DECK')
SUPPORT_DECK = Global.getVar('SUPPORT_DECK')
DEADLINE_DECK = Global.getVar('DEADLINE_DECK')
STORIES_DECK = Global.getVar('STORIES_DECK')
EDITOR_DECK = Global.getVar('EDITOR_DECK')

COLOR_DATA = Global.getTable('COLOR_DATA')

START_PLAYER_PAWN = Global.getVar('START_PLAYER_PAWN')

WEST_STORY_ZONES = Global.getTable('WEST_STORY_ZONES')
CENTRAL_STORY_ZONES = Global.getTable('CENTRAL_STORY_ZONES')
EAST_STORY_ZONES = Global.getTable('EAST_STORY_ZONES')

CURRENT_PLAYER = Global.getVar('CURRENT_PLAYER')
PLAYER_COUNT = 0

CHECKED = false

function gameSetup()
    PLAYER_COUNT = #getSeatedPlayers()
    -- if PLAYER_COUNT < 2 then
    --     broadcastToAll("Press 'Setup' again to when everyone is sitting at their color")
    --     return 1
    -- end
    if PLAYER_COUNT > 4 then
        broadcastToAll("This is a 4 player game!  Press setup again when you are down to 4")
        return 1
    end

    if not CHECKED then
        broadcastToAll("Press 'Setup' again to confirm everyone is sitting")
        CHECKED = true
        return 1
    end

    getObjectFromGUID(JOURNALISTS_DECK).randomize()
    getObjectFromGUID(STAFF_DECK).randomize()
    getObjectFromGUID(SUPPORT_DECK).randomize()
    getObjectFromGUID(DEADLINE_DECK).randomize()
    getObjectFromGUID(STORIES_DECK).randomize()
    getObjectFromGUID(EDITOR_DECK).randomize()

    fillStories(WEST_STORY_ZONES)
    fillStories(CENTRAL_STORY_ZONES)
    fillStories(EAST_STORY_ZONES)

    fillStaff()
    fillSupport()

    forEachPlayer(setupPlayer, COLOR_DATA)

    getObjectFromGUID(JOURNALISTS_DECK).deal(2)

    selectStartingPlayer()
    Global.call('dealJournalists')

    -- destroyObject(self)
    print('Setup Complete')
end

function fillStaff()
    local deck = getObjectFromGUID(STAFF_DECK)
    for i = 1, 6 do
        deck.takeObject({flip = true, position = {-4.2 - i * 3.67, 7, -1.1}})
    end
end

function fillSupport()
    local deck = getObjectFromGUID(SUPPORT_DECK)
    for i = 1, 6 do
        deck.takeObject({flip = true, position = {-4.2 - i * 3.67, 7, 30.81}})
    end
end

function setupPlayer(colorData)
    setupDept(colorData.token_bag, colorData.dept_offset)
    local editors = getObjectFromGUID(EDITOR_DECK)
    editors.takeObject({flip = true, position = colorData.editor_location})
end


function selectStartingPlayer()
    local v = math.random (1, PLAYER_COUNT)
    CURRENT_PLAYER = v
    Global.setVar('CURRENT_PLAYER', v)
    local player = getSeatedPlayers()[v]
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

function fillStories(zoneGuid)
    local deck = getObjectFromGUID(STORIES_DECK)
    for index, guid in ipairs(zoneGuid) do
        local zone = getObjectFromGUID(guid)
        if index == 1 or index == 2 or index == 4 or index == 6 then
            deck.takeObject({flip = true, position = zone.getPosition()  + Vector(0, 1, 0)})
        end
        if index == 3 and PLAYER_COUNT > 2 then
            deck.takeObject({flip = true, position = zone.getPosition()  + Vector(0, 1, 0)})
        end
        if index == 5 and PLAYER_COUNT > 3 then
            deck.takeObject({flip = true, position = zone.getPosition()  + Vector(0, 1, 0)})
        end
    end
end

function setupDept(bagGuid, offset)
    local bag = getObjectFromGUID(bagGuid)
    bag.takeObject({position = Vector(-23.42, 8, 7.37) + offset})
    bag.takeObject({position = Vector(-23.40, 8, 6.12) + offset})
    bag.takeObject({position = Vector(-23.40, 8, 4.82) + offset})
    bag.takeObject({position = Vector(-23.38, 8, 3.57) + offset})
end

--
-- Util Functions
--
function forEachPlayer(callback, params)
    for index, player in ipairs(getSeatedPlayers()) do
        if player == 'Teal' then
            callback(params.teal, index)
        end
        if player == 'Pink' then
            callback(params.pink, index)
        end
        if player == 'Green' then
            callback(params.green, index)
        end
        if player == 'Yellow' then
            callback(params.yellow, index)
        end
    end
end