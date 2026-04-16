-- border_wall/init.lua
-- Автор: Василь Онуфрійчук
-- Ліцензія: GNU GPL v3

-- Налаштування кордону
local WALL_MIN_X = -500
local WALL_MAX_X = 500
local WALL_MIN_Y = -1000
local WALL_MAX_Y = 50
local WALL_MIN_Z = -500
local WALL_MAX_Z = 500

-- Обмежуємо спавн гравця всередині кордону
minetest.register_on_joinplayer(function(player)
    local pos = player:get_pos()
    local x, y, z = pos.x, pos.y, pos.z

    if x < WALL_MIN_X then x = WALL_MIN_X end
    if x > WALL_MAX_X then x = WALL_MAX_X end
    if y < WALL_MIN_Y then y = WALL_MIN_Y end
    if y > WALL_MAX_Y then y = WALL_MAX_Y end
    if z < WALL_MIN_Z then z = WALL_MIN_Z end
    if z > WALL_MAX_Z then z = WALL_MAX_Z end

    player:set_pos({x=x, y=y, z=z})
end)

-- Обмежуємо рух гравця в реальному часі
minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local pos = player:get_pos()
        local x, y, z = pos.x, pos.y, pos.z
        local changed = false

        if x < WALL_MIN_X then x = WALL_MIN_X; changed = true end
        if x > WALL_MAX_X then x = WALL_MAX_X; changed = true end
        if y < WALL_MIN_Y then y = WALL_MIN_Y; changed = true end
        if y > WALL_MAX_Y then y = WALL_MAX_Y; changed = true end
        if z < WALL_MIN_Z then z = WALL_MIN_Z; changed = true end
        if z > WALL_MAX_Z then z = WALL_MAX_Z; changed = true end

        if changed then
            player:set_pos({x=x, y=y, z=z})
        end
    end
end)
