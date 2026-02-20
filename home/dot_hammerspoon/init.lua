-- Toggle WezTerm visibility with Cmd+W
-- Press once to bring WezTerm to the front, press again to hide it.
-- If WezTerm is not running, it will be launched.
-- Uses frontmostApplication() which captures state before focus shifts.
-- NOTE: This globally intercepts Cmd+W — normal close-window behavior is suppressed everywhere.

hs.hotkey.bind({'cmd'}, 'w', function()
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
