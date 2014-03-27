import XMonad

import qualified Data.Map as M

import qualified XMonad.StackSet as W

import XMonad.Layout
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Operations

import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName

--------------- Config --------------- 
cfg = myConfig { keys = flip mkKeymap $ myKeys }
myConfig = defaultConfig { modMask = mod4Mask
                         , terminal = "uxterm"
                         , workspaces = myWorkspaces
                         , layoutHook = myLayout
                         }


--------------- Workspaces --------------- 
myWorkspaces = ["1:Web", "2:Work", "3:IRC", "4", "5", "6", "7", "8", "9"]


--------------- Layout --------------- 
myLayout =
    smartBorders
    -- Full layout goes first in the Web workspace.
    . onWorkspace "1:Web" (Full ||| lTall ||| mTall)
    -- On the Work workspace, we use the tabbed layout first.
    . onWorkspace "2:Work" (lTabbed ||| lTall)
    -- On the IRC workspace, we can use Tall, Mirror tall, tabbed, and full.
    . onWorkspace "3:IRC" (lTall ||| mTall ||| lTabbed ||| Full)
    $ lTall ||| mTall ||| lTabbed ||| Full
    where lTall     = Tall 1 (3/100) (1/2)
          mTall     = Mirror lTall
          lTabbed   = simpleTabbed


--------------- Keys --------------- 
myKeys =
    [ ("M-r", refresh)

    -- Layout Hotkeys
    , ("M-<Return>", windows W.focusMaster)
    , ("M-e",    windows W.focusDown      )
    , ("M-w",    windows W.focusUp        )

    , ("M-S-<Return>", windows W.swapMaster)
    , ("M-S-e",        windows W.swapDown  )
    , ("M-S-w",        windows W.swapUp    )

    , ("M-z",    sendMessage FirstLayout)
    , ("M-x",    sendMessage NextLayout)

    , ("M-p",    withFocused $ windows . W.sink)

    -- Launch Programs
    , ("M-<Space>", spawn "dmenu_run -l 10")
    , ("M-t"      , spawn "uxterm -e tmux-menu")
    , ("M-v"      , spawn "pavucontrol")
    , ("M-l"      , spawn "slock")

    , ("M-q", restart "xmonad" True)
    , ("M-C-S-q", restart "/home/forkk/start-qtile" False)

    -- Misc
    , ("M-<Esc>"  , kill)

    -- Hacks
    , ("M-S-j", setWMName "LG3D")
    , ("M-S-k", setWMName "XMonad")

    ]
    ++
    -- Switching Workspaces
       [("M-" ++ (show i),   windows $ W.greedyView wspc) | (wspc, i) <- zip myWorkspaces [1..9]]
    ++ [("M-S-" ++ (show i), windows $ W.shift wspc) | (wspc, i) <- zip myWorkspaces [1..9]]


--------------- Status Bar --------------- 
myStatusBar cfg =
    statusBar "xmobar ~/.xmonad/xmobar.cfg" xmobarPP toggleBarKey cfg


toggleBarKey XConfig{modMask = modm} = (modm, xK_b)

main = xmonad =<< myStatusBar cfg



