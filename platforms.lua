--platforms.lua

local platforms = {}

local platformImg
local platformWidth
local platformHeight

function platforms.load(images)
    platformImg = images.platformImg
    platformWidth = platformImg:getWidth()
    platformHeight = platformImg:getHeight()
end

function platforms.addPlatform(x, y)
    table.insert(platforms, {
        x = x,
        y = y,
        w = platformWidth,
        h = platformHeight
    })
end

function platforms.update(dt)
    -- Placeholder function in case we want to add animations or effects later
end

function platforms.resolveCollisions(player, previousY)
    for _, p in ipairs(platforms) do
        if isColliding(player, p) then
            local previousBottom = previousY + player.h
            local platformTop = p.y

            -- If we were above the platform last frame and now intersect it,
            -- snap to the top of the platform.
            if previousBottom <= platformTop then
                player.y = platformTop - player.h
                player.vy = 0
                player.onGround = true
            end
        end
    end
end

function platforms.draw()
    for _, p in ipairs(platforms) do
        love.graphics.draw(platformImg, p.x, p.y)
    end
end

-- Simple AABB collision helper
function isColliding(obj1, obj2)
    local x1 = obj1.x
    local y1 = obj1.y
    local w1 = obj1.w
    local h1 = obj1.h
    local x2 = obj2.x
    local y2 = obj2.y
    local w2 = obj2.w
    local h2 = obj2.h
    
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

return platforms