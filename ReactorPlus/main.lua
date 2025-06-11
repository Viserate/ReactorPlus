
-- /ReactorPlus/main.lua
local ui = require("ui")

ui.init()

while true do
    ui.update()
    if peripheral.find("monitor") then
        ui.checkInput()
    end
    sleep(0.25)
end
