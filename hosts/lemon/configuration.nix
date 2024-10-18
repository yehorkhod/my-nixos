{ config, pkgs, inputs, ... }:

let
  username = "yehorkhod";
  userDescription = "Yehor Khodysko";
  homeDirectory = "/home/${username}";
  hostName = "lemon";
  timeZone = "Europe/Kyiv";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules/nvidia.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = hostName;
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

  programs = { # TODO
    neovim.enable = true;
    firefox.enable = true;
    tmux.enable = true;
    thunar.enable = true;
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
    neovim helix

    # Browsers
    firefox
    inputs.zen-browser.packages."${system}".default

    # Communication
    telegram-desktop discord zoom-us

    # System monitoring and management
    btop

    # Version control and development
    git devenv

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

    ollama = {
      enable=true;
      acceleration = "cuda";
    };

    openssh.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
  };

  security.rtkit.enable = true;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://devenv.cachix.org" ];
      trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  system.stateVersion = "24.05";
}
