{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      windowManager = {
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = haskellPackages: [ ];
        };
      };
    };

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

    ollama = {
      enable = true;
      acceleration = "cuda";
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

    openssh.enable = true;

    printing.enable = true;

    displayManager.ly.enable = true;

    udev.packages = with pkgs; [ vial ];

    picom.enable = true;

    pulseaudio.enable = false;
  };
}
