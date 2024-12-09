{ config, pkgs, inputs, username, hostname, ... }:

let
  userDescription = "My configuration";
  homeDirectory = "/home/${username}";
  timeZone = "Europe/Kyiv";
in
{
  imports = [
    ../../hardware-configuration.nix
    ../../nixosModules/nvidia.nix
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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs = {
    neovim.enable = true;
    firefox.enable = true;
    tmux.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  # User
  users.users.${username} = {
    isNormalUser = true;
    description = userDescription;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  environment.systemPackages = with pkgs; [
    # Text editors
    neovim helix jetbrains-toolbox

    # Browsers
    firefox
    (surf.overrideAttrs (old: {
      patches = [ ../../patches/surf-bookmarks.diff ];
    }))
    inputs.zen-browser.packages."${system}".default

    # Communication
    telegram-desktop discord zoom-us

    # System monitoring and management
    btop

    # Version control and development
    git conda

    # Shell and terminal
    starship kitty zoxide fzf tmux wget

    # Office
    libreoffice-qt

    # File management and archives
    zip unzip

    # Videos
    vlc obs-studio

    # Fancy stuff
    pinta neofetch

    # System utils
    brightnessctl
    alsa-utils alsa-tools pamixer
    ripgrep libnotify libgcc

    # X11
    xclip shotgun hacksaw
  ];

  users.extraGroups.docker.members = [ "yehorkhod" ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings = {
      data-root = "/home/yehorkhod/docker-data";
      userland-proxy = false;
    };
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
