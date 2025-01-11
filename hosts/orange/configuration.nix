{ config, pkgs, inputs, configs, ... }:

let
  username = configs.username;
in
{
  imports = [
    ../../hardware-configuration.nix
    ../../nixos-modules/nvidia.nix
    ../../nixos-modules/boot.nix
    ../../nixos-modules/fonts.nix
    ../../nixos-modules/users.nix
    ../../nixos-modules/networking.nix
    ../../nixos-modules/locale.nix
    inputs.xremap-flake.nixosModules.default
  ];

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
  };

  nixpkgs.config.allowUnfree = true;

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
      xclip shotgun hacksaw
      libnotify
      pavucontrol
    ];
    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
    };
  };

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
