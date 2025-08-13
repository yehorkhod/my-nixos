{ pkgs, username, ... }:

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
    xremap = {
      withX11 = true;
      userName = username;
      yamlConfig = ''
        modmap:
          - name: main remaps
            remap:
              CapsLock:
                held: Super_L
                alone: esc
      '';
    };
    openssh.enable = true;
    blueman.enable = true;
    printing.enable = true;
    displayManager.ly.enable = true;
    udev.packages = with pkgs; [ vial ];
    picom.enable = true;
    pulseaudio.enable = false;
  };
}
