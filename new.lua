rednet.open("back")  -- change if your modem is on another side

-- Broadcast to let main system know this mirror exists
local label = os.getComputerLabel() or ("Mirror_" .. os.getComputerID())
local registerMsg = textutils.serialize({
    type = "mirror_ready",
    id = os.getComputerID(),
    label = label
})
rednet.broadcast(registerMsg)

-- Locate all attached monitors
local monitors = {}
for _, name in ipairs(peripheral.getNames()) do
    if peripheral.getType(name) == "monitor" then
        local mon = peripheral.wrap(name)
        if mon then
            mon.setTextScale(0.5)
            mon.setBackgroundColor(colors.black)
            mon.setTextColor(colors.white)
            mon.clear()
            table.insert(monitors, mon)
        end
    end
end

-- Listen and render
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
