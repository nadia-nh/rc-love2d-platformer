-- player.lua

local player = {}

local playerImg

function player.load(images)
    playerImg = images.playerImg
    player.w = playerImg:getWidth()
    player.h = playerImg:getHeight()

    -- Spawn position (where the player starts and respawns)
    player.spawnX = 100
    player.spawnY = 300

    -- Current position
    player.x = player.spawnX
    player.y = player.spawnY

    player.vx = 0
    player.vy = 0
    player.speed = 100
    player.onGround = false
end

function player.respawn()
    player.x = player.spawnX
    player.y = player.spawnY
    player.vx = 0
    player.vy = 0
    player.onGround = false
end

function player.update(dt, gravity)
    -- Set horizontal velocity
    if love.keyboard.isDown("left") then
        player.vx = -player.speed
    elseif love.keyboard.isDown("right") then
        player.vx = player.speed
    else
        player.vx = 0
    end

    -- Apply gravity
    player.vy = player.vy + gravity * dt

    -- Move horizontally
    player.x = player.x + player.vx * dt

    -- Move vertically
    local previousY = player.y
    player.y = player.y + player.vy * dt
    player.onGround = false
end

function player.jump(jumpStrength)
    if player.onGround then
        player.vy = -jumpStrength
        player.onGround = false
    end
end

function player.draw()
    love.graphics.draw(playerImg, player.x, player.y)
end

return player