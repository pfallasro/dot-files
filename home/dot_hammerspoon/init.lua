-- Toggle WezTerm visibility with Cmd+Shift+Z
-- Press once to bring WezTerm to the front, press again to hide it.
-- If WezTerm is not running, it will be launched.
-- Uses frontmostApplication() which captures state before focus shifts.

hs.hotkey.bind({'cmd', 'shift'}, 'z', function()
  local frontApp = hs.application.frontmostApplication()
  local wezterm  = hs.application.get('WezTerm')

  if wezterm == nil then
    hs.application.launchOrFocus('WezTerm')
  elseif frontApp:name() == 'WezTerm' then
    wezterm:hide()
  else
    wezterm:activate()
  end
end)
