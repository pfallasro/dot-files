-- Toggle WezTerm visibility with Cmd+W
-- Press once to bring WezTerm to the current desktop, press again to hide it.
-- Requires WezTerm set to "All Desktops" (right-click Dock icon → Options → All Desktops).
-- If WezTerm is not running, it will be launched.
-- NOTE: This globally intercepts Cmd+W — normal close-window behavior is suppressed everywhere.

local WEZTERM_BUNDLE = 'com.github.wez.wezterm'

hs.hotkey.bind({'cmd'}, 'w', function()
  local frontApp = hs.application.frontmostApplication()
  local wezterm  = hs.application.get(WEZTERM_BUNDLE)

  if wezterm == nil then
    hs.application.launchOrFocusByBundleID(WEZTERM_BUNDLE)
  elseif frontApp:bundleID() == WEZTERM_BUNDLE then
    wezterm:hide()
  else
    wezterm:activate()
  end
end)
