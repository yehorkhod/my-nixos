{ config, pkgs, ... }:

let
  directory = ./.;
in
{
  programs.waybar = {
    enable = true;

    settings = {
      bar = {
        layer = "top";
        modules-left = [ "battery" "memory" ];
        modules-right = [ "custom/lock" "clock" "custom/power-menu" ];
  
        memory = {
          interval = 30;
          format = "💾 {}%";
          tooltip-format ="{used:0.1f}GB";
        };
  
        battery = {
          bat = "BAT1";
          interval = 30;
          states = {
            good = 95;
            warning = 30;
            critical = 5;
          };
          format = "⚡ {capacity}%";
  
          format-charging = "⚡ {capacity}% (charging)";
          format-plugged = "⚡ {capacity}% (plugged)";
        };
  
        "custom/lock" = {
          tooltip  = false;
          on-click = "swaylock";
          format  = "LOCK";
        };
  
        clock = {
          format = "{:%H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            format = {
              months = "<span color='#f07016'><b>{}</b></span>";
              today = "<span color='#ff6699'><b>{}</b></span>";
            };
          };
        };
  
        "custom/power-menu" = {
          format = "⏻ POWER";
          on-click = "bash ${directory}/powermenu/powermenu.sh &";
        }; 
      };
    };

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font, Iosevka Nerd Font;
        font-size: 19px;
      }
      
      #waybar {
          background-color: rgba(51, 51, 51, 0.0);
          color: #ffffff;
      }
      
      #memory,
      #memory {
        color: #5b8291;
      }
      
      #battery,
      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
      
      #custom-lock,
      #custom-lock {
        color: #ecd3a0;
        padding: 0 15px 0 15px;
        margin-left: 7px;
        margin-top: 7px;
        margin-bottom: 7px;
      }
      
      #clock,
      #clock {
        color: #8a909e;
        font-family: Iosevka Nerd Font;
        font-weight: bold;
        margin-top: 7px;
        margin-bottom: 7px;
      }
      
      #custom-power-menu,
      #custom-power-menu {
        color: #e78284;
        margin-right: 12px;
        border-radius: 12px;
        padding: 0 6px 0 3px;
        margin-top: 7px;
        margin-bottom: 7px;
      }
      
      #memory, #battery, #custom-lock, #clock, #custom-power-menu {
        padding: 5px 10px;
        margin: 0 5px;
        border-radius: 5px;
        background-color: rgba(255, 255, 255, 0.1); /* Semi-transparent background */
        transition: background-color 0.3s ease;
      }
    '';
  };
}
