COLOR_DATA = Global.getTable('COLOR_DATA')

IS_ZONE_ACTIVE = true

function toggleZones()
    local pinkZone = getObjectFromGUID(COLOR_DATA.pink.action_zone)
    local tealZone = getObjectFromGUID(COLOR_DATA.teal.action_zone)
    local greenZone = getObjectFromGUID(COLOR_DATA.green.action_zone)
    local yellowZone = getObjectFromGUID(COLOR_DATA.yellow.action_zone)

    if IS_ZONE_ACTIVE then

        pinkZone.setPositionSmooth(pinkZone.getPosition() + Vector(0, -3, 0))
        tealZone.setPositionSmooth(tealZone.getPosition() + Vector(0, -3, 0))
        greenZone.setPositionSmooth(greenZone.getPosition() + Vector(0, -3, 0))
        yellowZone.setPositionSmooth(yellowZone.getPosition() + Vector(0, -3, 0))
    end
    if not IS_ZONE_ACTIVE then
        pinkZone.setPositionSmooth(pinkZone.getPosition() + Vector(0, 3, 0))
        tealZone.setPositionSmooth(tealZone.getPosition() + Vector(0, 3, 0))
        greenZone.setPositionSmooth(greenZone.getPosition() + Vector(0, 3, 0))
        yellowZone.setPositionSmooth(yellowZone.getPosition() + Vector(0, 3, 0))
        Wait.frames(cleanAllColorUp, 20)
    end

    IS_ZONE_ACTIVE = not IS_ZONE_ACTIVE
end

function cleanAllColorUp()
    cleanColorUp(COLOR_DATA.pink)
    cleanColorUp(COLOR_DATA.teal)
    cleanColorUp(COLOR_DATA.green)
    cleanColorUp(COLOR_DATA.yellow)
end

function cleanColorUp(colorData)
    local actionZone = getObjectFromGUID(colorData.action_zone)

    for _, obj in ipairs(actionZone.getObjects()) do
        local tokenIndex = isToken(colorData.number_tokens, obj.getGUID())
        if tokenIndex > 0 then
            local returnLoc = colorData.number_token_locations[math.ceil(tokenIndex/3)]
            if obj.getRotation()[3] > 170 and obj.getRotation()[3] < 361 then
                obj.flip()
            end
            obj.setPositionSmooth(
                Vector(returnLoc) + Vector(0, math.random(1,5), 0)
            )
        end
    end
end

function isToken(tokenList, token)
    for index, value in ipairs(tokenList) do
        if value == token then
            return index
        end
    end

    return -1
end