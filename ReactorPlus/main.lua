local config = require("config")
local state = require("state")
local ui = require("ui")
local input = require("input")
local pid = require("pid")
local scan = require("peripheral_scan")
local helpers = require("helpers")

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
