{ config, pkgs, ... }:

let directory = ./.;
in {
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
          tooltip-format = "{used:0.1f}GB";
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
          tooltip = false;
          on-click = "swaylock";
          format = "LOCK";
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

    style = builtins.readFile "${directory}/style.css";
  };
}
