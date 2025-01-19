{ ... }:

{
  hardware = {
    pulseaudio.enable = false;
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
