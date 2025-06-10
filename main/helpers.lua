local function applyRodLevel(level)
    local r = peripheral.find("reactor")
    if r then
        r.setAllControlRodLevels(math.floor(level))
    end
end

return {
    applyRodLevel = applyRodLevel
}
