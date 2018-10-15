{-# LANGUAGE UnicodeSyntax #-}

import XMonad
import XMonad.Actions.PhysicalScreens
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Grid

import Graphics.X11.ExtraTypes.XF86
import Graphics.X11.Xinerama

main = do
    let uhook = withUrgencyHookC NoUrgencyHook urgentConfig
    let conf = uhook myConfig
    monitorsCount >>= \cnt -> case cnt of
        1 -> xmonad =<< statusBar myBar myPP toggleStrutsKey conf
        _ -> xmonad =<< statusBar myLeftBar myLeftPP toggleStrutsKey =<< statusBar myRightBar myRightPP toggleStrutsKey conf

monitorsCount = fmap length $ getScreenInfo =<< openDisplay ""

myConfig = defaultConfig
    { terminal          = terminal'
    , workspaces        = workspaces'
    , layoutHook        = layoutHook'
    , startupHook       = startupHook'
    , manageHook        = manageHook' <+> manageDocks <+> manageHook defaultConfig
    , modMask           = modMask'
    , focusFollowsMouse = False
    }
    `additionalKeys` keys'
    `additionalKeysP` keysP'

modMask' = mod4Mask

terminal' = "urxvt"

workspaces' = ["im", "web", "term", "dev", "unity", "read", "video", "mus", "unknown"]

myBar = "xmobar"

myLeftBar = myBar ++ " -x 0 .xmobarrc.left"

myRightBar = myBar ++ " -x 1 .xmobarrc.right"

myPP = xmobarPP { ppCurrent = xmobarColor "#859900" "" . wrap "<" ">"
                , ppUrgent = xmobarColor "#dc322f" "" . wrap "[" "]" . xmobarStrip
                , ppTitle = \_ → ""
                , ppSep = xmobarColor "#268bd2" "" " <+> "
                }

myLeftPP = myPP

myRightPP = myPP { ppTitle = shorten 80 }

toggleStrutsKey _ = (modMask' .|. shiftMask, xK_t)

urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }

layoutHook' = smartBorders $ avoidStruts
    $ onWorkspace "im" (Full ||| Grid)
    $ onWorkspace "web" (Full ||| Grid)
    $ onWorkspace "term" (Grid ||| Full)
    $ onWorkspace "dev" Full
    $ layoutHook defaultConfig

startupHook' = do
    setWMName "LG3D"
    spawn "~/.xmonad/startup-hook"

manageHook' = composeAll
    [ className =? "slack"            --> doShift "im"
    , className =? "chromium-browser" --> doShift "web"
    , className =? "Unity"            --> doShift "unity"
    , title =? "zathura"              --> doShift "read"
    , className =? "Gxmessage"        --> doFloat
    , className =? "Kodi"             --> doFloat
    , className =? "mpv"              --> doFloat
    , title =? "xmessage"             --> doFloat
    , title =? "Starting Unity..."    --> doFloat
    , title =? "Hold On"              --> doFloat
    ]

keys' =
    [ ((mask .|. modMask', key), φ scr)
        | (key, scr) ← zip [xK_w, xK_e, xK_r] [0..]
    , (φ, mask)  ← [(viewScreen, 0), (sendToScreen, shiftMask)]]
    ++
    [ ((modMask' .|. shiftMask, xK_space), spawn $ terminal' ++ " -e fish -i -c vifm")
    , ((0, xK_Print), spawn "scrot -e 'mv $f ~/shots/; scrot-loader ~/shots/$n'")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/shots/; scrot-loader ~/shots/$n'")
    , ((modMask', xK_Print), spawn "sleep 0.2; scrot -b -e 'mv $f ~/shots/; scrot-loader ~/shots/$n'")
    , ((0, 0x1008ff81), spawn "xmessage hello")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 5%+")
    , ((0, xF86XK_AudioMute), spawn "amixer set Master toggle")
    ]

keysP' =
    [ ("M-S-l", spawn "light-locker-command --lock")
    , ("M-x c", spawn "chromium")
    , ("M-x x", spawn "chromium --incognito")
    , ("M-x v", spawn $ terminal' ++ " -e bash -i -c vim")
    , ("M-x u", spawn "unity-editor")
    , ("M-x s", spawn "slack")
    , ("M-x p", spawn "zathura")
    ]
