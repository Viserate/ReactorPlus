rednet.open("back")  -- change if needed

local monitors = {}

-- Wrap and store all monitors
for _, name in ipairs(peripheral.getNames()) do
    if peripheral.getType(name) == "monitor" then
        local mon = peripheral.wrap(name)
        if mon then
            table.insert(monitors, mon)
        end
    end
end

-- Configure all found monitors
for _, mon in ipairs(monitors) do
    mon.setTextScale(0.5)
    mon.setBackgroundColor(colors.black)
    mon.setTextColor(colors.white)
    mon.clear()
end

-- Main loop to receive and display
while true do
    local _, msg = rednet.receive()
    for _, mon in ipairs(monitors) do
        mon.clear()
        mon.setCursorPos(1, 1)
        local y = 1
        for line in string.gmatch(msg, "[^\n]+") do
            mon.setCursorPos(1, y)
            mon.write(line)
            y = y + 1
        end
    end
end
