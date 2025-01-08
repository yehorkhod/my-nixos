--------------------------- IMPORTS ----------------------------
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Actions.CycleWS (nextWS, prevWS)
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--------------------------- CONFIGS ----------------------------
myTerminal           = "kitty"
myBrowser            = "qutebrowser"
myMessanger          = "telegram-desktop"
appLauncher          = "dmenu_run"
myBorderWidth        = 2
myModMask            = mod4Mask
myWorkspaces         = ["1","2","3","4","5","6","7","8","9"]
myNormalBorderColor  = "#374247"
myFocusedBorderColor = "#dbbc7f"
screenshotScript     = "shotgun /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png"
cropAndScreenshot    = "shotgun -g $(hacksaw) /tmp/image.png && xclip -selection clipboard -t image/png -i /tmp/image.png"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myClickJustFocuses :: Bool
myClickJustFocuses = False

------------------------- KEY BINDINGS -------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_c), kill)  -- close focused window
    ------------ Volume ------------
    , ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 10")  -- Lower Volume
    , ((0, xF86XK_AudioRaiseVolume), spawn "pamixer -i 10")  -- Raise Volume
    , ((0, xF86XK_AudioMute       ), spawn "pamixer -t"   )  -- Mute Volume
    ---------- Brightness ----------
    , ((0, xF86XK_MonBrightnessUp  ), spawn "brightnessctl s 10%+")  -- Raise Brightness
    , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 10%-")  -- Lower Brightness
    ---------- Screenshot ----------
    , ((0,                  xK_Print), spawn screenshotScript )  -- Screenshot of whole screen
    , ((modm .|. shiftMask, xK_s    ), spawn cropAndScreenshot)  -- Crop`N`Screenshot
    ---------- Workspaces ----------
    , ((modm, xK_l), nextWS)  -- Move to the next workspace
    , ((modm, xK_h), prevWS)  -- Move to the previous workspace
    ------------ Layout ------------
    , ((modm,               xK_period), sendMessage (IncMasterN ( 1))     )  -- Increment the number of windows in the master area
    , ((modm,               xK_comma ), sendMessage (IncMasterN (-1))     )  -- Deincrement the number of windows in the master area
    , ((modm,               xK_o     ), sendMessage NextLayout            )  -- Rotate through the available layout algorithms
    , ((modm,               xK_p     ), withFocused $ windows . W.sink    )  -- Push window back into tiling
    , ((modm,               xK_j     ), windows W.focusDown               )  -- Move focus to the next window
    , ((modm,               xK_k     ), windows W.focusUp                 )  -- Move focus to the previous window
    , ((modm,               xK_f     ), windows W.focusMaster             )  -- Move focus to the master window
    , ((modm .|. shiftMask, xK_f     ), windows W.swapMaster              )  -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_h     ), sendMessage Shrink                )  -- Shrink the master area
    , ((modm .|. shiftMask, xK_l     ), sendMessage Expand                )  -- Expand the master area
    , ((modm .|. shiftMask, xK_o     ), setLayout $ XMonad.layoutHook conf)  -- Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown                )  -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp                  )  -- Swap the focused window with the previous window
    ----------- Programs -----------
    , ((modm, xK_d        ), spawn appLauncher)
    , ((modm, xK_Return   ), spawn myTerminal )
    , ((modm, xK_backslash), spawn myBrowser  )
    , ((modm, xK_t        ), spawn myMessanger)
    ------------ Xmonad ------------
    , ((modm,               xK_q), spawn "xmonad --recompile; xmonad --restart")  -- Restart xmonad
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)                   )  -- Quit xmonad
    ]
    ++
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------ MOUSE BINDINGS ------------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

--------------------------- LAYOUTS ----------------------------
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
    -- default tiling algorithm partitions the screen into two panes
    tiled   = Tall nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio   = 1/2
    -- Percent of screen to increment by when resizing panes
    delta   = 3/100

------------------------- WINDOW RULES -------------------------
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"         --> doFloat
    , className =? "TelegramDesktop" --> doFloat
    , className =? "Matplotlib"      --> doFloat
    , className =? "Gimp"            --> doFloat
    , resource  =? "desktop_window"  --> doIgnore
    , resource  =? "kdesktop"        --> doIgnore ]

------------------------ EVENT HANDLING ------------------------
-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------- LOGGING HOOK -------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------- STARTUP HOOK -------------------------
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    spawn "feh --bg-fill /home/yehorkhod/System/wallpapers/eva.jpg"
    spawn "setxkbmap -layout us,ua -option grp:win_space_toggle"

------------------------- XMONAD STUFF -------------------------
-- Now run xmonad with all the defaults we set up.
-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmproc <- spawnPipe "polybar"
    xmonad $ docks defaults
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,
    -- hooks, layouts
    layoutHook         = myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
}
