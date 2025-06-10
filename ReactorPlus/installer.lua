-- Installer for ReactorPlus
local files = {
    "config.lua",
    "main.lua",
    "pid.lua",
    "input.lua",
    "ui.lua",
    "helpers.lua",
    "peripheral_scan.lua",
    "state.lua"
}

local baseUrl = "https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/ReactorPlus/main/"

fs.makeDir("ReactorPlus")

for _, file in ipairs(files) do
    local res = http.get(baseUrl .. file)
    if res then
        local handle = fs.open("ReactorPlus/" .. file, "w")
        handle.write(res.readAll())
        handle.close()
        print("Installed: " .. file)
    else
        print("Failed to download: " .. file)
    end
end

-- Create startup.lua
local startup = fs.open("startup.lua", "w")
startup.write('shell.run("ReactorPlus/main.lua")\n')
startup.close()

print("ReactorPlus installed! Rebooting...")
sleep(2)
os.reboot()
