module Borders where

import Graphics.X11.Xlib (Dimension)


myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#403d52"

myFocusedBorderColor :: String
myFocusedBorderColor = "#31748f"
