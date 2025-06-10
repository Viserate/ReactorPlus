local config = require("ReactorPlus.config")
local state = require("ReactorPlus.state")
local ui = require("ReactorPlus.ui")
local input = require("ReactorPlus.input")
local pid = require("ReactorPlus.pid")
local scan = require("ReactorPlus.peripheral_scan")
local helpers = require("ReactorPlus.helpers")

-- Initial setup
scan.detect()
ui.init()
input.listen()

print("ReactorPlus starting...")
sleep(config.startupDelay)

while true do
    ui.update()
    if not config.manualMode then
        local output = pid.calculate()
        helpers.applyRodLevel(output)
    end
    sleep(config.displayUpdateInterval)
end
