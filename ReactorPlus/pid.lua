local config = require("ReactorPlus.config")
local state = require("ReactorPlus.state")

local integral = 0
local previous_error = 0

local function calculate()
    local target = 0.75
    local current = state.getEnergyPercent()

    local error = target - current
    if math.abs(error) < config.pid.deadband then return state.lastRodLevel end

    integral = integral + error
    local derivative = error - previous_error
    previous_error = error

    local output = config.pid.kp * error + config.pid.ki * integral + config.pid.kd * derivative
    local rodLevel = math.min(100, math.max(0, 100 - (output * 100)))
    state.lastRodLevel = rodLevel
    return rodLevel
end

return {
    calculate = calculate
}
