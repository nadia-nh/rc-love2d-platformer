--coins.lua

local coins = {}

local coinImg
local coinWidth
local coinHeight
local coinCount = 0

function coins.load(images)
    coinImg = images.coinImg
    coinWidth = coinImg:getWidth()
    coinHeight = coinImg:getHeight()
end

function coins.addCoin(x, y)
    table.insert(coins, {
        x = x,
        y = y,
        w = coinWidth,
        h = coinHeight,
        collected = false
    })
end

function coins.update(dt)
    -- Placeholder function in case we want to add animations or effects later
end

function coins.handleCollection(player)
    for _, coin in ipairs(coins) do
        if not coin.collected and isColliding(player, coin) then
            coin.collected = true
            coinCount = coinCount + 1
        end
    end
end

function coins.getCount()
    return coinCount
end

function coins.reset()
    for _, coin in ipairs(coins) do
        coin.collected = false
    end
    coinCount = 0
end

function coins.draw()
    for _, coin in ipairs(coins) do
        if not coin.collected then
            love.graphics.draw(coinImg, coin.x, coin.y)
        end
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


return coins