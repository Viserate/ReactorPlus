-- Safe installer for low-space CC systems
local files = {
  "config.lua", "main.lua", "pid.lua", "input.lua", "ui.lua",
  "helpers.lua", "peripheral_scan.lua", "state.lua",
  -- Basalt core
  "basalt.lua",
  -- Basalt subfiles
  "basalt/main.lua",
  "basalt/theme.lua",
  "basalt/events/event.lua",
  "basalt/objects/button.lua",
  "basalt/objects/label.lua",
  "basalt/objects/frame.lua",
  "basalt/objects/progressbar.lua"
  -- (Add more as needed)
}

local base = "https://raw.githubusercontent.com/Viserate/ReactorPlus/main/ReactorPlus/"
fs.makeDir("ReactorPlus")

for _, file in ipairs(files) do
  local url = base .. file
  local res = http.get(url)
  if res then
    local handle = fs.open("ReactorPlus/" .. file, "w")
    handle.write(res.readAll())
    handle.close()
    print("Installed:", file)
  else
    print("Failed to download:", file)
  end
end

-- Create startup file
local startup = fs.open("startup.lua", "w")
startup.write('shell.run("ReactorPlus/main.lua")')
startup.close()

print("Install complete. Rebooting...")
sleep(2)
os.reboot()
