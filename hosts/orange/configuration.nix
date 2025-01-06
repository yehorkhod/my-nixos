{ config, pkgs, inputs, configs, ... }:

let
  username = configs.username;
  hostname = configs.hostname;
  userDescription = "My configuration";
  homeDirectory = "/home/${username}";
  timeZone = "Europe/Kyiv";
in
{
  imports = [
    ../../hardware-configuration.nix
    ../../nixos-modules/nvidia.nix
    inputs.xremap-flake.nixosModules.default
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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "uk_UA.UTF-8";
      LC_IDENTIFICATION = "uk_UA.UTF-8";
      LC_MEASUREMENT = "uk_UA.UTF-8";
      LC_MONETARY = "uk_UA.UTF-8";
      LC_NAME = "uk_UA.UTF-8";
      LC_NUMERIC = "uk_UA.UTF-8";
      LC_PAPER = "uk_UA.UTF-8";
      LC_TELEPHONE = "uk_UA.UTF-8";
      LC_TIME = "uk_UA.UTF-8";
    };
  };

  programs = {
    gnupg.agent.enable = true;
    neovim.enable = true;
    tmux.enable = true;

    # Games
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  environment = {
    systemPackages = with pkgs; [
      # Text editors
      neovim helix jetbrains-toolbox

      # Browsers
      qutebrowser

      # Communication
      telegram-desktop discord zoom-us

      # Work
      git conda docker-compose
      kitty tmux btop
      (callPackage ../../nixos-modules/pilot/default.nix { inherit pkgs; })

      # Apps
      libreoffice-qt pavucontrol
      vlc obs-studio pinta slides

      # Utils
      brightnessctl zip unzip
      alsa-utils alsa-tools pamixer
      ripgrep libnotify libgcc bc
      xclip shotgun hacksaw pass
      wget starship fzf neofetch

      # Games
      mangohud protonup
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
    };
  };

  users.extraGroups.docker.members = [ "yehorkhod" ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings.userland-proxy = false;
  };

  fonts.packages = with pkgs; [
    corefonts
    vistafonts
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "JetBrainsMono"
        "3270"
      ];
    })
  ];
  
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager.gdm.enable = true;
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks
          luadbi-mysql
        ];
      };
    };

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

    picom.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    graphics.enable = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  security.rtkit.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  system.stateVersion = "24.05";
}
