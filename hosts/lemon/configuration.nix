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
    ../../nixos-modules/boot.nix
    ../../nixos-modules/fonts.nix
  ];

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
    neovim.enable = true;
    gnupg.agent.enable = true;
    tmux.enable = true;

    # Games
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
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
    systemPackages = with pkgs;
    let
      tex = (pkgs.texlive.combine
        { inherit (pkgs.texlive) scheme-basic latexmk; });
      pilot = (callPackage
        ../../nixos-modules/pilot/default.nix
        { inherit pkgs; });
    in
    [
      # Text editors
      neovim helix jetbrains-toolbox

      # Communication
      telegram-desktop discord zoom-us

      # Work
      git conda docker-compose
      kitty tmux btop pilot

      # Apps
      libreoffice-qt vlc obs-studio
      pinta slides qutebrowser zathura

      # Global Utils
      brightnessctl zip unzip bc
      starship fzf neofetch wget 
      alsa-utils alsa-tools pamixer
      pass tex ripgrep libgcc

      # Games
      mangohud protonup

      # Specifics
      grim slurp waybar dunst wl-clipboard swaylock
      swaynotificationcenter swaybg rofi-wayland
      libnotify swappy light imagemagick
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
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

    ollama = {
      enable = true;
      acceleration = "cuda";
    };
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
