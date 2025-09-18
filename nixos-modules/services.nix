{ pkgs, ... }:

{
  services = {
    picom.enable = true;
    displayManager.ly.enable = true;
    xserver = {
      enable = true;
      windowManager.dwm = {
        enable = true;
        package = pkgs.dwm.overrideAttrs { src = ../suckless/dwm; };
      };
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    interception-tools =
      let
        itools = pkgs.interception-tools;
        dualfn = pkgs.interception-tools-plugins.dual-function-keys;
      in
      {
        enable = true;
        plugins = [ dualfn ];
        udevmonConfig = pkgs.lib.mkDefault ''
          - JOB: "${itools}/bin/intercept -g $DEVNODE | ${dualfn}/bin/dual-function-keys -c /etc/dualfn.yaml | ${itools}/bin/uinput -d $DEVNODE"
            DEVICE:
              EVENTS:
                EV_KEY: [KEY_CAPSLOCK]
        '';
      };

    udev.packages = with pkgs; [ vial ];

    openssh.enable = true;

    ollama = {
      enable = true;
      acceleration = "cuda";
    };
  };
}
