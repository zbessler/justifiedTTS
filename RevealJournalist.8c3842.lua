COLOR_DATA = Global.getTable('COLOR_DATA')

IS_ZONE_ACTIVE = true

function flipZones()
    local pinkZone = getObjectFromGUID(COLOR_DATA.pink.play_zone)
    local tealZone = getObjectFromGUID(COLOR_DATA.teal.play_zone)
    local greenZone = getObjectFromGUID(COLOR_DATA.green.play_zone)
    local yellowZone = getObjectFromGUID(COLOR_DATA.yellow.play_zone)

    for _, obj in ipairs(pinkZone.getObjects()) do
        if obj.getRotation()[3] > 170 and obj.getRotation()[3] < 361 then
            obj.flip()
        end
    end
    for _, obj in ipairs(tealZone.getObjects()) do
        if obj.getRotation()[3] > 170 and obj.getRotation()[3] < 361 then
            obj.flip()
        end
    end
    for _, obj in ipairs(greenZone.getObjects()) do
        if obj.getRotation()[3] > 170 and obj.getRotation()[3] < 361 then
            obj.flip()
        end
    end
    for _, obj in ipairs(yellowZone.getObjects()) do
        if obj.getRotation()[3] > 170 and obj.getRotation()[3] < 361 then
            obj.flip()
        end
    end
end