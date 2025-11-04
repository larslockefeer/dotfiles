// Configuration
require("./config/phoenix/config/constants.js");
require("./config/phoenix/config/phoenix.js");

// Helpers
require("./config/phoenix/helpers/center_window.js");
require("./config/phoenix/helpers/get_named_anchor.js");
require("./config/phoenix/helpers/get_named_frame.js");
require("./config/phoenix/helpers/screen.js");
require("./config/phoenix/helpers/set_anchor.js");
require("./config/phoenix/helpers/set_frame.js");
require("./config/phoenix/helpers/set_key_handler.js");
require("./config/phoenix/helpers/set_keys_handler.js");

// Keyboard shortcuts
require("./config/phoenix/keyboard_shortcuts/move_screens.js")
require("./config/phoenix/keyboard_shortcuts/window_expand.js");
require("./config/phoenix/keyboard_shortcuts/window_sides.js");

Phoenix.log("Phoenix configuration loaded.");
