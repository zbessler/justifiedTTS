COLOR_DATA = Global.getTable('COLOR_DATA')

IS_ZONE_ACTIVE = true

function clearZones()
    cleanColorUp(COLOR_DATA.pink)
    cleanColorUp(COLOR_DATA.teal)
    cleanColorUp(COLOR_DATA.green)
    cleanColorUp(COLOR_DATA.yellow)
end

function cleanColorUp(colorData)
    local playZone = getObjectFromGUID(colorData.play_zone)
    local actionZone = getObjectFromGUID(colorData.play_zone)

    for _, obj in ipairs(playZone.getObjects()) do
        if obj.type == "Card" then
            obj.deal(1, colorData.color)
        end

        local tokenIndex = isToken(colorData.number_tokens, obj.getGUID())
        if tokenIndex > 0 then
            local returnLoc = colorData.number_token_locations[math.ceil(tokenIndex/3)]
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