module Variables where

import           Graphics.X11.Xlib (KeyMask, mod4Mask)


-- Apps
myTerminal :: String
myTerminal = "kitty"
myBrowser :: String
myBrowser = "qutebrowser"
myMessanger :: String
myMessanger = "Telegram"
appLauncher :: String
appLauncher = "dmenu_run"

-- Screenshots
screenshotScript :: String
screenshotScript = "shotgun /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png"
cropAndScreenshot :: String
cropAndScreenshot = "shotgun -g $(slop) /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png"

-- Focus
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Other Configurations
myWorkspaces :: [String]
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]
myModMask :: KeyMask
myModMask = mod4Mask
