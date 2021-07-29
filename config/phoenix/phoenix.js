// Configuration
require("./config/constants.js");
require("./config/phoenix.js");

// Helpers
require("./helpers/center_window.js");
require("./helpers/get_named_frame.js");
require("./helpers/screen.js");
require("./helpers/set_frame.js");
require("./helpers/set_key_handler.js");
require("./helpers/set_keys_handler.js");

// Keyboard shortcuts
require("./keyboard_shortcuts/move_screens.js")
require("./keyboard_shortcuts/window_expand.js");
require("./keyboard_shortcuts/window_sides.js");

Phoenix.log("Phoenix configuration loaded.");
