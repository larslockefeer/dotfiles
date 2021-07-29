function moveToScreen(window, screen) {
    if (!window) return;
    if (!screen) return;
  
    const frame = window.frame();
    const oldScreenRect = window.screen().visibleFrameInRectangle();
    const newScreenRect = screen.visibleFrameInRectangle();

    const oldXPos = frame.x + Math.round(0.5 * frame.width);
    const oldYPos = frame.y + Math.round(0.5 * frame.height);

    const newWidth = Math.min(newScreenRect.width, frame.width);
    const newHeight = Math.min(newScreenRect.height, frame.height);

    const newXPos = (oldXPos - oldScreenRect.x) + newScreenRect.x - 0.5 * newWidth;
    const newYPos = (oldYPos - oldScreenRect.y) + newScreenRect.y - 0.5 * newHeight;
  
    window.setFrame({
      x: newXPos,
      y: newYPos,
      width: newWidth,
      height: newHeight
    });
  };
