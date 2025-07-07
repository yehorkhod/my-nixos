--------------------------- IMPORTS ----------------------------
import           Borders
import qualified Data.Map                      as M
import           Data.Monoid
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           Variables
import           XMonad
import           XMonad.Actions.CycleWS        (nextWS, prevWS)
import           XMonad.Hooks.ManageDocks      (ToggleStruts (..), avoidStruts,
                                                docks)
import           XMonad.Hooks.WindowSwallowing
import qualified XMonad.StackSet               as W
import           XMonad.Util.Run
import           XMonad.Util.SpawnOnce

------------------------- KEY BINDINGS -------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_c), kill)
    ------------ Volume ------------
    , ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 10")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pamixer -i 10")
    , ((0, xF86XK_AudioMute       ), spawn "pamixer -t"   )
    ---------- Brightness ----------
    , ((0, xF86XK_MonBrightnessUp  ), spawn "brightnessctl s 10%+")
    , ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 10%-")
    ---------- Screenshot ----------
    , ((0,                  xK_Print), spawn screenshotScript )
    , ((modm .|. shiftMask, xK_s    ), spawn cropAndScreenshot)
    ---------- Workspaces ----------
    , ((modm, xK_l), nextWS)
    , ((modm, xK_h), prevWS)
    ------------ Layout ------------
    , ((modm,               xK_period), sendMessage (IncMasterN   1 )     )
    , ((modm,               xK_comma ), sendMessage (IncMasterN (-1))     )
    , ((modm,               xK_o     ), sendMessage NextLayout            )
    , ((modm,               xK_p     ), withFocused $ windows . W.sink    )
    , ((modm,               xK_j     ), windows W.focusDown               )
    , ((modm,               xK_k     ), windows W.focusUp                 )
    , ((modm,               xK_f     ), windows W.focusMaster             )
    , ((modm .|. shiftMask, xK_f     ), windows W.swapMaster              )
    , ((modm .|. shiftMask, xK_h     ), sendMessage Shrink                )
    , ((modm .|. shiftMask, xK_l     ), sendMessage Expand                )
    , ((modm .|. shiftMask, xK_o     ), setLayout $ XMonad.layoutHook conf)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown                )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp                  )
    ------------ Layout ------------
    , ((modm, xK_b), sendMessage ToggleStruts)
    ----------- Programs -----------
    , ((modm, xK_d), spawn appLauncher)
    ------------ Xmonad ------------
    , ((modm,               xK_q), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. shiftMask, xK_q), io (exitWith ExitSuccess)                   )
    ]

------------------------ MOUSE BINDINGS ------------------------
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster  )
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster                       )
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

--------------------------- LAYOUTS ----------------------------
myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
    tiled   = Tall nmaster delta ratio
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

------------------------- WINDOW RULES -------------------------
myManageHook = composeAll
    [ className =? "MPlayer"                  --> doFloat
    , className =? "TelegramDesktop"          --> doFloat
    , className =? "Matplotlib"               --> doFloat
    , className =? "Gimp"                     --> doFloat
    , className =? ".blueman-manager-wrapped" --> doFloat
    , className =? "kitty"                    --> doShift "1"
    , className =? "qutebrowser"              --> doShift "2"
    , className =? "TelegramDesktop"          --> doShift "3"
    , resource  =? "desktop_window"           --> doIgnore
    , resource  =? "kdesktop"                 --> doIgnore ]

------------------------ EVENT HANDLING ------------------------
myEventHook = swallowEventHook (className =? "kitty") (return True)

------------------------- LOGGING HOOK -------------------------
myLogHook = return ()

------------------------- STARTUP HOOK -------------------------
myStartupHook = do
    spawnOnce myTerminal
    spawnOnce myBrowser
    spawnOnce myMessanger
    spawn "feh --bg-fill /home/yehorkhod/wallpaper.png"
    spawn "setxkbmap -layout us,ua -option grp:win_space_toggle"

------------------------- XMONAD STUFF -------------------------
main = do
    xmproc <- spawnPipe "pkill -x polybar; polybar"
    xmonad $ docks defaults

defaults = def {
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    clickJustFocuses   = myClickJustFocuses,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,
    keys               = myKeys,
    mouseBindings      = myMouseBindings,
    layoutHook         = myLayout,
    manageHook         = myManageHook,
    handleEventHook    = myEventHook,
    logHook            = myLogHook,
    startupHook        = myStartupHook
}
