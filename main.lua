-- main.lua
-- Very simple platformer demo in LÖVE (love2d)
-- Controls: Left/Right arrows to move, Up to jump

local player = require("player")
local platforms = require("platforms")
local coins = require("coins")

local gravity = 700
local jumpStrength = 400
local DEATH_Y

-- Images
local images = {}

local platformWidth
local platformHeight
local coinWidth
local coinHeight

function love.load()
    love.window.setTitle("Simple Platformer")
    love.window.setMode(800, 450)

    local windowWidth, windowHeight = love.graphics.getDimensions()
    DEATH_Y = windowHeight + 100 -- some margin below the visible area

    -- Load images
    images.playerImg     = love.graphics.newImage("assets/player.png")
    images.platformImg   = love.graphics.newImage("assets/platform.png")
    images.coinImg       = love.graphics.newImage("assets/coin.png")

    platformWidth   = images.platformImg:getWidth()
    platformHeight  = images.platformImg:getHeight()
    coinWidth       = images.coinImg:getWidth()
    coinHeight      = images.coinImg:getHeight()

    player.load(images)
    coins.load(images)
    platforms.load(images)

    initializePlatforms()
end

-- Ground platforms + floating platforms with coins
function initializePlatforms()
    local groundY = 380
    for i = 1, 3 do
        platforms.addPlatform(platformWidth * (i - 1), groundY)
    end

    local floatingStartX = platformWidth * 3 + 30
    local floatingStartY = groundY - 80
    addFloatingPlatforms(floatingStartX, floatingStartY, 3, true)
    floatingStartX = floatingStartX + platformWidth * 3 + 40
    floatingStartY = floatingStartY - 60
    addFloatingPlatforms(floatingStartX, floatingStartY, 4, true)
    floatingStartX = floatingStartX + platformWidth * 4 + 50
    floatingStartY = floatingStartY + 100
    addFloatingPlatforms(floatingStartX, floatingStartY, 1, false)
    floatingStartX = floatingStartX + platformWidth + 60
    floatingStartY = floatingStartY - 70
    addFloatingPlatforms(floatingStartX, floatingStartY, 2, true)
end

-- Floating platforms + coins
function addFloatingPlatforms(startX, startY, count, addCoins)
    for i = 1, count do
        platforms.addPlatform(
            startX + platformWidth * (i - 1),
            startY
        )

        if addCoins then
            coins.addCoin(
                startX + platformWidth * (i - 1) + (platformWidth - coinWidth) / 3,
                startY - coinHeight
            )
        end
    end
end

function love.update(dt)
    local previousY = player.y
    player.update(dt, gravity)
    platforms.resolveCollisions(player, previousY)
    platforms.update(dt)
    coins.handleCollection(player)
    coins.update(dt)

    -- Detect if we fell off the map:
    if player.y > DEATH_Y then
        player.respawn()
        coins.reset()
    end
end

function love.keypressed(key)
    if key == "up" then
        player.jump(jumpStrength)
    end

    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    drawBackground()
    platforms.draw()
    coins.draw()
    player.draw()
    drawUIText()
end

function drawBackground()
    love.graphics.clear(0.4, 0.7, 1.0) -- blue sky
end

function drawUIText()
    love.graphics.print("Coins: " .. coins.getCount(), 10, 10)
    love.graphics.print("Arrows to move, Up to jump, Esc to quit", 10, 30)
end
