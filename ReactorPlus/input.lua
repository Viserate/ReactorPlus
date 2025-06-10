local config = require("ReactorPlus.config")
local state = require("ReactorPlus.state")

local function listen()
    parallel.waitForAny(function()
        while true do
            local event, side, x, y = os.pullEvent("monitor_touch")
            state.manualRodLevel = math.floor((x / 30) * 100)
            config.manualMode = true
        end
    end)
end

return {
    listen = listen
}
