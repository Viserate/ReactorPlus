-- ReactorPlus + Basalt Full Installer

local reactorFiles = {
  "main.lua", "config.lua", "pid.lua", "input.lua",
  "ui.lua", "state.lua", "helpers.lua", "peripheral_scan.lua"
}

local basaltFiles = {
  "basalt.lua",
  "basalt/init.lua",
  "basalt/loadObjects.lua",
  "basalt/main.lua",
  "basalt/plugin.lua",
  -- Libraries
  "basalt/libraries/basaltDraw.lua",
  "basalt/libraries/basaltEvent.lua",
  "basalt/libraries/basaltLogs.lua",
  "basalt/libraries/basaltMon.lua",
  "basalt/libraries/bimg.lua",
  "basalt/libraries/images.lua",
  "basalt/libraries/process.lua",
  "basalt/libraries/reactivePrimitives.lua",
  "basalt/libraries/tHex.lua",
  "basalt/libraries/utils.lua",
  "basalt/libraries/xmlParser.lua",
  -- Objects
  "basalt/objects/BaseFrame.lua",
  "basalt/objects/Button.lua",
  "basalt/objects/ChangeableObject.lua",
  "basalt/objects/Checkbox.lua",
  "basalt/objects/Container.lua",
  "basalt/objects/Dropdown.lua",
  "basalt/objects/Flexbox.lua",
  "basalt/objects/Frame.lua",
  "basalt/objects/Graph.lua",
  "basalt/objects/Image.lua",
  "basalt/objects/Input.lua",
  "basalt/objects/Label.lua",
  "basalt/objects/List.lua",
  "basalt/objects/Menubar.lua",
  "basalt/objects/MonitorFrame.lua",
  "basalt/objects/MovableFrame.lua",
  "basalt/objects/Object.lua",
  "basalt/objects/Pane.lua",
  "basalt/objects/Program.lua",
  "basalt/objects/Progressbar.lua",
  "basalt/objects/Radio.lua",
  "basalt/objects/ScrollableFrame.lua",
  "basalt/objects/Scrollbar.lua",
  "basalt/objects/Slider.lua",
  "basalt/objects/Switch.lua",
  "basalt/objects/Textfield.lua",
  "basalt/objects/Thread.lua",
  "basalt/objects/Timer.lua",
  "basalt/objects/Treeview.lua",
  "basalt/objects/VisualObject.lua",
  -- Plugins
  "basalt/plugins/advancedBackground.lua",
  "basalt/plugins/animations.lua",
  "basalt/plugins/basaltAdditions.lua",
  "basalt/plugins/bigfonts.lua",
  "basalt/plugins/border.lua",
  "basalt/plugins/debug.lua",
  "basalt/plugins/dynamicValues.lua",
  "basalt/plugins/pixelbox.lua",
  "basalt/plugins/reactive.lua",
  "basalt/plugins/shadow.lua",
  "basalt/plugins/textures.lua",
  "basalt/plugins/themes.lua"
}

local baseUrl = "https://raw.githubusercontent.com/Viserate/ReactorPlus/main/"

-- Create required directories
fs.makeDir("ReactorPlus")
fs.makeDir("basalt")
fs.makeDir("basalt/libraries")
fs.makeDir("basalt/objects")
fs.makeDir("basalt/plugins")

-- Download ReactorPlus files
for _, file in ipairs(reactorFiles) do
  local url = baseUrl .. "ReactorPlus/" .. file
  local path = "ReactorPlus/" .. file
  local res = http.get(url)
  if res then
    local h = fs.open(path, "w")
    h.write(res.readAll())
    h.close()
    print("✓ ReactorPlus: " .. file)
  else
    print("✗ Failed: " .. file)
  end
end

-- Download Basalt files
for _, file in ipairs(basaltFiles) do
  local url = baseUrl .. file
  local path = file
  local res = http.get(url)
  if res then
    local h = fs.open(path, "w")
    h.write(res.readAll())
    h.close()
    print("✓ Basalt: " .. file)
  else
    print("✗ Failed: " .. file)
  end
end

-- Create startup file
local startup = fs.open("startup.lua", "w")
startup.write('shell.run("ReactorPlus/main.lua")\n')
startup.close()

print("\n✅ Installation complete. Rebooting...")
sleep(2)
os.reboot()
