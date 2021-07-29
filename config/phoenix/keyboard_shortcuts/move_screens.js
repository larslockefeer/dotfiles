setKeyHandler("\\", HYPER, () => {
  const window = Window.focused();
  if (!window) return;

  if (window.screen() === window.screen().next()) return;

  moveToScreen(window, window.screen().next());
  window.focus();
});

setKeyHandler("'", HYPER, () => {
  const window = Window.focused();
  if (!window) return;

  if (window.screen() === window.screen().next()) return;

  moveToScreen(window, window.screen().previous());
  window.focus();
});
