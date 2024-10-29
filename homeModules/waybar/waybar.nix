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

        margin-top = 5;
        margin-left = 5;
        margin-right = 5;

        modules-left = [ "battery" "memory" ];
        modules-right = [ "custom/lock" "clock" ];
  
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
      };
    };

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font, Iosevka Nerd Font;
        font-size: 16px;
      }
      
      #waybar {
        background-color: rgba(255, 255, 255, .5);
        border-radius: 16px;
      }
      
      #memory,
      #memory {
        color: #5b8291;
      }
      
      #battery,
      #battery.critical:not(.charging) {
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
      }
      
      #clock,
      #clock {
        color: #8a909e;
        font-family: Iosevka Nerd Font;
        font-weight: bold;
      }
      
      #memory, #battery, #custom-lock, #clock {
        padding: 0 10px 0 10px;

        margin-top: 2px;
        margin-bottom: 2px;
        margin-left: 2px;
        margin-right: 2px;

        border-radius: 16px;
        background-color: rgba(0, 0, 0, 0.7);
        transition: background-color 0.3s ease;
      }
    '';
  };
}
