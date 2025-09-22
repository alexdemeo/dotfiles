function alert(msg)
  print(msg)
  hs.alert.show(msg)
end

function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end

mash = { 'ctrl', 'option', 'cmd' }

-- BEGIN functions to change screens

mode = #hs.screen.allScreens() == 1 and "singleScreen" or "multiScreen"
print("starting with mode", mode)

function moveUpScreen()
  local focused = hs.window.focusedWindow()
  local f = focused:frame()
  local up = focused:screen():toNorth():frame()
  f.x = up.x
  f.y = up.y
  f.w = up.w
  f.h = up.h
  focused:setFrame(f)
end

function moveDownScreen()
  local focused = hs.window.focusedWindow()
  local f = focused:frame()
  local up = focused:screen():toSouth():frame()
  f.x = up.x
  f.y = up.y
  f.w = up.w
  f.h = up.h
  focused:setFrame(f)
end

function moveLeftScreen()
  local focused = hs.window.focusedWindow()
  local f = focused:frame()
  local up = focused:screen():toWest():frame()
  f.x = up.x
  f.y = up.y
  f.w = up.w
  f.h = up.h
  focused:setFrame(f)
end

function moveRightScreen()
  local focused = hs.window.focusedWindow()
  local f = focused:frame()
  local up = focused:screen():toEast():frame()
  f.x = up.x
  f.y = up.y
  f.w = up.w
  f.h = up.h
  focused:setFrame(f)
end

function resizeTopHalf()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end

function resizeLeftHalf()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function resizeRightHalf()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function resizeBottomHalf()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y + max.h / 2
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end

hs.hotkey.bind(mash, "up", function()
  if mode == "singleScreen" then
    resizeTopHalf()
  else
    moveUpScreen()
  end
end)

hs.hotkey.bind(mash, "down", function()
  if mode == "singleScreen" then
    resizeBottomHalf()
  else
    moveDownScreen()
  end
end)

hs.hotkey.bind(mash, "left", function()
  if mode == "singleScreen" then
    resizeLeftHalf()
  else
    moveLeftScreen()
  end
end)

hs.hotkey.bind(mash, "right", function()
  if mode == "singleScreen" then
    resizeRightHalf()
  else
    moveRightScreen()
  end
end)

-- END functions to change screens
-- BEGIN functions to size within a screen

hs.hotkey.bind(mash, "pad0", function()
  local focused = hs.window.focusedWindow()
  local f = focused:frame()
  local up = focused:screen():frame()
  f.x = up.x
  f.y = up.y
  f.w = up.w
  f.h = up.h
  focused:setFrame(f)
end)

hs.hotkey.bind(mash, 'pad8', resizeTopHalf)

hs.hotkey.bind(mash, 'pad2', resizeBottomHalf)

hs.hotkey.bind(mash, 'pad4', resizeLeftHalf)

hs.hotkey.bind(mash, 'pad6', resizeRightHalf)

hs.hotkey.bind(mash, 'pad7', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, 'pad9', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x + max.w / 2
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, 'pad1', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x
  f.y = max.y + max.h / 2
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, 'pad3', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  f.x = max.x + max.w / 2
  f.y = max.y + max.h / 2
  f.w = max.w / 2
  f.h = max.h / 2
  win:setFrame(f)
end)

hs.hotkey.bind(mash, 'pad5', function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = win:screen():frame()
  local ratio = 1 / 6
  f.x = max.x + max.w * ratio
  f.y = max.y + max.h * ratio
  f.w = max.w * (1 - 2 * ratio)
  f.h = max.h * (1 - 2 * ratio)
  win:setFrame(f)
end)

-- END functions to size within a screen

hs.hotkey.bind(mash, 'z', function()
  hs.eventtap.keyStroke({ 'shift', 'alt' }, 'right')
  hs.eventtap.keyStroke({}, 'forwarddelete')
  hs.eventtap.keyStroke({}, 'forwarddelete')
  hs.eventtap.keyStroke({ 'shift', 'alt' }, 'right')
  hs.eventtap.keyStroke({}, '\'')
end)

hs.hotkey.bind(mash, "r", function()
  hs.reload()
end)

hs.hotkey.bind(mash, "v", function()
  local contents = hs.pasteboard.getContents()
  local qIdx = contents:find('?')
  if( qIdx )
  then
    local stripped = contents:sub(0, qIdx - 1)
    hs.pasteboard.setContents(stripped)
    alert(stripped)
    hs.eventtap.keyStrokes(stripped)
  else
    alert('no ? in contents, use normal paste instead')
  end
end)

usbWatcher = hs.screen.watcher.new(function()
  local numScreens = #hs.screen.allScreens()
  if numScreens == 1 then
    mode = "singleScreen"
  else
    mode = "multiScreen"
  end
  print("switched to move", mode)
end):start()

function toggleScrollDirection()
  script = [[
    tell application "System Settings"
      do shell script "open x-apple.systempreferences:com.apple.Trackpad-Settings.extension"
    end tell

    delay 0.5

    tell application "System Events" to tell process "System Settings"
      click radio button 2 of tab group 1 of group 1 of group 3 of splitter group 1 of group 1 of window "Trackpad"
      click checkbox 1 of group 1 of scroll area 1 of group 1 of group 3 of splitter group 1 of group 1 of window "Trackpad"
    end tell

    delay 0.5

    quit application "System Settings"

  ]]
  hs.osascript.applescript(script)
end

hs.hotkey.bind(mash, "\\", toggleScrollDirection)

function getSelectedText()
  local originalClipboard = hs.pasteboard.getContents()
  hs.pasteboard.clearContents()
  hs.eventtap.keyStroke({ "cmd" }, "c", 0.2)
  hs.timer.usleep(200000)
  local newText = hs.pasteboard.getContents()
  hs.pasteboard.setContents(originalClipboard)
  return newText
end

hs.hotkey.bind(mash, "p", function()
  local prompt = getSelectedText()
  local result = hs.execute("~/dotfiles/.venv/bin/python3 ~/dotfiles/python/meta_prompt.py '" .. prompt .. "'", false)
  print(result)
  hs.pasteboard.setContents(result)
  alert("Prompt generated and saved to clipboard")
end)

alert("Config loaded")
