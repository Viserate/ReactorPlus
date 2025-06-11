local device = peripheral.find("monitor") or term
local usingMonitor = device ~= term

-- Helper to write centered text
local function centerText(y, text)
    local w, _ = device.getSize()
    local x = math.floor((w - #text) / 2) + 1
    device.setCursorPos(x, y)
    device.write(text)
end

-- Draws a horizontal progress bar
local function drawBar(x, y, w, percent, label)
    percent = math.max(0, math.min(1, percent))
    local fill = math.floor(w * percent)
    device.setCursorPos(x, y)
    device.write(label .. ": [")
    for i = 1, w do
        if i <= fill then
            device.write("=")
        else
            device.write(" ")
        end
    end
    device.write("]")
end

local function init()
    if usingMonitor then
        device.setTextScale(0.5)
    end
    device.clear()
    device.setCursorPos(1, 1)
    centerText(1, "ReactorPlus")
end

local function update()
    device.clear()
    local width, height = device.getSize()
    local energy = require("state").getEnergyPercent() -- must return 0–1
    local temp = require("state").getTemperature() or 0 -- optional

    centerText(1, "ReactorPlus")
    drawBar(2, 3, width - 4, energy, "Energy")

    device.setCursorPos(2, 5)
    device.write("Temp: " .. tostring(temp) .. " C")
end

return {
    init = init,
    update = update
}
