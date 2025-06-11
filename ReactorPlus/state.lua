-- /ReactorPlus/state.lua
local t = 0
local statusToggle = true

return {
    getEnergyPercent = function()
        t = (t + 0.01) % 1
        return t
    end,

    getTemperature = function()
        return math.floor(300 + math.sin(t * math.pi * 2) * 100)
    end,

    getReactorStatus = function()
        return statusToggle and "ONLINE" or "OFFLINE"
    end,

    toggleStatus = function()
        statusToggle = not statusToggle
    end
}


