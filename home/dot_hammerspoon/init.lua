-- Toggle WezTerm visibility with Cmd+`
-- Press once to bring WezTerm to the front, press again to hide it.
-- If WezTerm is not running, it will be launched.

hs.hotkey.bind({'cmd'}, '`', function()
  local wezterm = hs.application.get('WezTerm')
  if wezterm == nil then
    hs.application.launchOrFocus('WezTerm')
  elseif wezterm:isFrontmost() then
    wezterm:hide()
  else
    wezterm:activate()
  end
end)
