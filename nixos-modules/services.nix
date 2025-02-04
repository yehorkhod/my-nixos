{ pkgs, ... }:

{
  services = {
    printing.enable = true;

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

    openssh.enable = true;

    blueman.enable = true;

    ollama = {
      enable = true;
      acceleration = "cuda";
    };
    udev.packages = with pkgs; [ vial via ];
  };
}
