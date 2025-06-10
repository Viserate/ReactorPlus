local basalt = require("basalt")
local config = require("ReactorPlus.config")
local state = require("ReactorPlus.state")

local main
local bar

local function init()
    main = basalt.createFrame()
    bar = main:addProgressbar():setPosition(2, 2):setSize(30, 1)
    main:addLabel():setText("ReactorPlus"):setPosition(2, 1)
    main:show()
end

local function update()
    local percent = state.getEnergyPercent() * 100
    bar:setProgress(percent)
    basalt.run()
end

return {
    init = init,
    update = update
}
