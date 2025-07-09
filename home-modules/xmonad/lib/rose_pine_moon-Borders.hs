module Borders where

import           Graphics.X11.Xlib (Dimension)


myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#232136"

myFocusedBorderColor :: String
myFocusedBorderColor = "#e0def4"
