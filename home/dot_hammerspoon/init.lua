-- Toggle WezTerm visibility with Cmd+W
-- Press once to bring WezTerm to the current workspace, press again to hide it.
-- If WezTerm is not running, it will be launched.
-- NOTE: This globally intercepts Cmd+W — normal close-window behavior is suppressed everywhere.

local WEZTERM_BUNDLE = 'org.wezfurlong.wezterm'

hs.hotkey.bind({'cmd'}, 'w', function()
  local frontApp = hs.application.frontmostApplication()
  local wezterm  = hs.application.get(WEZTERM_BUNDLE)

  if wezterm == nil then
    hs.application.launchOrFocusByBundleID(WEZTERM_BUNDLE)
  elseif frontApp:bundleID() == WEZTERM_BUNDLE then
    wezterm:hide()
  else
    local win = wezterm:mainWindow()
    if win then
      local currentSpace = hs.spaces.focusedSpace()
      hs.spaces.moveWindowToSpace(win, currentSpace)
      win:focus()
    else
      hs.application.launchOrFocusByBundleID(WEZTERM_BUNDLE)
    end
  end
end)
