module Borders where

import Graphics.X11.Xlib (Dimension)


myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#928374"

myFocusedBorderColor :: String
myFocusedBorderColor = "#d79921"
