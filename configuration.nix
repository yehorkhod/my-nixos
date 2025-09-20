{ username, hostname, timeZone, ... }:

{
  imports = [
    ./nixos-modules/nvidia.nix
    ./nixos-modules/packages.nix
    ./nixos-modules/services.nix
    ./nixos-modules/hardware.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  time.timeZone = timeZone;

  # services

  users = {
    users.${username} = {
      isNormalUser = true;
      description = "description";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
    extraGroups.docker.members = [ username ];
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings.userland-proxy = false;
  };

  security.rtkit.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  system.stateVersion = "24.05";
}
