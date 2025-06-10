local state = require("ReactorPlus.state")

local function detect()
    for _, name in ipairs(peripheral.getNames()) do
        local p = peripheral.wrap(name)
        if p.getEnergy and p.getMaxEnergy then
            table.insert(state.externalBatteries, p)
        elseif p.getEnergyStored and p.getFuelAmount then
            state.reactor = p
        end
    end
end

return {
    detect = detect
}
