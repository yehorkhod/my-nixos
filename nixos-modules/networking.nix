{ config, lib, pkgs, configs, ... }:

let hostname = configs.hostname;
in {
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
}
