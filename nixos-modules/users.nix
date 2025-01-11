{ config, lib, pkgs, configs, ... }:

let
  username = configs.username;
  userDescription = "ULTRA";
in
{
  users = {
    users.${username} = {
      isNormalUser = true;
      description = userDescription;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
    extraGroups.docker.members = [ username ];
  };
}
