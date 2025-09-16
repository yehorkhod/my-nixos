{ config, ... }:

let
  # `nix shell nixpkgs#pciutils -c lspci | grep ' VGA '` to check the bus id
  intelBusId = "PCI:0:2:0";
  nvidiaBusId = "PCI:1:0:0";
in
{
  nixpkgs.config.cudaSupport = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    graphics.enable = true;
    nvidia = {
      open = false;
      nvidiaSettings = true;
      modesetting.enable = true;

      powerManagement = {
        enable = false;
        finegrained = false;
      };

      package = config.boot.kernelPackages.nvidiaPackages.production;

      prime = {
        reverseSync.enable = true;
        allowExternalGpu = false;

        intelBusId = intelBusId;
        nvidiaBusId = nvidiaBusId;
      };
    };
  };
}
