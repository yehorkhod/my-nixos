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

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    # Text editors
    neovim helix

    # Browsers
    firefox

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
    unzip

    # Fancy stuff
    pinta neofetch

    # System utils
    brightnessctl ripgrep libnotify libgcc swappy
    alsa-utils alsa-tools pamixer light imagemagick

    # Wayland specific
    grim slurp waybar dunst wl-clipboard swaylock
    swaynotificationcenter swaybg rofi-wayland
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
      desktopManager.gnome.enable = true;
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  stylix = {
    enable = true;
    
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    
    base16Scheme = {
      base00 = "191724";
      base01 = "1f1d2e";
      base02 = "26233a";
      base03 = "6e6a86";
      base04 = "908caa";
      base05 = "e0def4";
      base06 = "e0def4";
      base07 = "524f67";
      base08 = "eb6f92";
      base09 = "f6c177";
      base0A = "ebbcba";
      base0B = "31748f";
      base0C = "9ccfd8";
      base0D = "c4a7e7";
      base0E = "f6c177";
      base0F = "524f67";
    };

    image = ../home-modules/awesome/background.png;
  };

  system.stateVersion = "24.05";
}
