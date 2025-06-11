-- /ReactorPlus/ui.lua
local device = peripheral.find("monitor") or term
local usingMonitor = device ~= term
local state = require("state")

if usingMonitor then
    device.setTextScale(0.5)
end

local function clear()
    device.setBackgroundColor(colors.black)
    device.clear()
    device.setCursorPos(1, 1)
end

local function centerText(y, text, color)
    local w, _ = device.getSize()
    local x = math.floor((w - #text) / 2) + 1
    device.setCursorPos(x, y)
    if color then
        device.setTextColor(color)
    end
    device.write(text)
    device.setTextColor(colors.white)
end

local function drawBar(x, y, width, percent, label, barColor, bgColor)
    percent = math.max(0, math.min(1, percent))
    local fill = math.floor(width * percent)

    device.setCursorPos(x, y)
    device.setTextColor(colors.white)
    device.write(label .. ": [")

    for i = 1, width do
        if i <= fill then
            device.setBackgroundColor(barColor)
        else
            device.setBackgroundColor(bgColor)
        end
        device.write(" ")
    end

    device.setBackgroundColor(colors.black)
    device.write("]")
end

local function init()
    clear()
    centerText(1, "ReactorPlus Monitor", colors.cyan)
end

local function update()
    local width, _ = device.getSize()

    local energy = state.getEnergyPercent() or 0
    local temp = state.getTemperature() or 0
    local status = state.getReactorStatus() or "UNKNOWN"

    clear()
    centerText(1, "ReactorPlus Monitor", colors.cyan)
    drawBar(2, 3, width - 4, energy, "Energy", colors.green, colors.gray)

    device.setCursorPos(2, 5)
    device.setTextColor(colors.orange)
    device.write("Temperature: ")
    device.setTextColor(colors.white)
    device.write(temp .. " C")

    device.setCursorPos(2, 6)
    device.setTextColor(colors.orange)
    device.write("Reactor Status: ")
    device.setTextColor(status == "ONLINE" and colors.lime or colors.red)
    device.write(status)
end

local function checkInput()
    if usingMonitor then
        local event, side, x, y = os.pullEvent("monitor_touch")
        if y == 6 then
            state.toggleStatus()
        end
    end
end

return {
    init = init,
    update = update,
    checkInput = checkInput
}
