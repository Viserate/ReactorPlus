local t = 0
return {
    getEnergyPercent = function()
        t = (t + 0.01) % 1
        return t
    end,
    getTemperature = function()
        return math.floor(300 + math.sin(t * math.pi * 2) * 100)
    end
}
