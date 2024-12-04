{ config, pkgs, ... }:

let
  directory = ./.;
  wallpapers-directory = ../../wallpapers;
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "rofi -show run";
      "$browser" = "zen";
      "$messager" = "telegram-desktop";

      monitor = "eDP-1, 1920x1080@60, 0x0, 1, bitdepth, 10";

      exec-once = [
        "waybar"
        "dunst"
        "swaybg -o \\* -i ${wallpapers-directory}/space.png -m fill"
      ];

      general = {
          gaps_in = 5;
          gaps_out = 5;
      
          border_size = 0;
      
          layout = "dwindle";
      };

      decoration = {
          rounding = 10;
      
          active_opacity = 1.0;
          inactive_opacity = 0.9;
      
          blur = {
              enabled = false;
          };
      };

      animations = {
          enabled = false;
      };

      dwindle = {
          pseudotile = true;
          preserve_split = true;
      };
      
      master = {
          new_status = "master";
      };
      
      misc = { 
          disable_hyprland_logo = true;
      };

      input = {
          kb_layout = "us, ua";
          kb_options = "caps:escape, grp:win_space_toggle";
      
          follow_mouse = 0;
      
          sensitivity = 0;
      
          touchpad = {
              natural_scroll = false;
          };
      };

      gestures = {
          workspace_swipe = true;
          workspace_swipe_min_speed_to_force = 10;
      };

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, F, exec, $browser"
        "$mainMod, D, exec, $menu"
        "$mainMod, T, exec, $messager"
      
        "$mainMod, C, killactive,"

        "$mainMod, O, togglesplit,"
        "$mainMod, M, togglefloating,"
        "$mainMod, I, fullscreen, 0"
      
        "$mainMod Shift, S, exec, grim -g \"$(slurp)\" - | magick - -shave 1x1 PNG:- | swappy -f -"
        "$mainMod Shift, W, exec, grim -g \"$(slurp)\" - | magick - -shave 1x1 PNG:- | wl-copy"
      
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
      
        "$mainMod Shift, H, movewindow, l"
        "$mainMod Shift, L, movewindow, r"
        "$mainMod Shift, K, movewindow, u"
        "$mainMod Shift, J, movewindow, d"
      
        "$mainMod, Left, resizeactive, -40 0"
        "$mainMod, Right, resizeactive, 40 0"
        "$mainMod, Up, resizeactive, 0 -40"
        "$mainMod, Down, resizeactive, 0 40"
      
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
      
        "$mainMod Shift, 1, movetoworkspace, 1"
        "$mainMod Shift, 2, movetoworkspace, 2"
        "$mainMod Shift, 3, movetoworkspace, 3"
        "$mainMod Shift, 4, movetoworkspace, 4"
        "$mainMod Shift, 5, movetoworkspace, 5"
        "$mainMod Shift, 6, movetoworkspace, 6"
        "$mainMod Shift, 7, movetoworkspace, 7"
        "$mainMod Shift, 8, movetoworkspace, 8"
        "$mainMod Shift, 9, movetoworkspace, 9"
        "$mainMod Shift, 0, movetoworkspace, 10"
      
        "$mainMod, S, togglespecialworkspace, magic"
      
        ", XF86AudioMute, exec, ${directory}/scripts/volume mute"
        ", XF86AudioLowerVolume, exec, ${directory}/scripts/volume down"
        ", XF86AudioRaiseVolume, exec, ${directory}/scripts/volume up"
      ];

      bindle = [
        ", XF86MonBrightnessUp, exec, ${directory}/scripts/brightness up"
        ", XF86MonBrightnessDown, exec, ${directory}/scripts/brightness down"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];

      windowrule = [
        "float, ^(pinta)$"
      ];
    };
  };
}
