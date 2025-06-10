local state = {
    externalBatteries = {},
    reactor = nil,
    manualRodLevel = 0,
    lastRodLevel = 0
}

function state.getEnergyPercent()
    if #state.externalBatteries == 0 then return 0 end
    local total = 0
    local max = 0
    for _, bat in ipairs(state.externalBatteries) do
        total = total + bat.getEnergy()
        max = max + bat.getMaxEnergy()
    end
    return total / max
end

return state
