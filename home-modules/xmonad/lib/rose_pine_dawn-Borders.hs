module Borders where

import           Graphics.X11.Xlib (Dimension)


myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#faf4ed"

myFocusedBorderColor :: String
myFocusedBorderColor = "#575279"
