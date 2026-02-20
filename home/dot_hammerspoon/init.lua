-- Toggle WezTerm visibility with Cmd+W
-- Press once to bring WezTerm to the front, press again to hide it.
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
