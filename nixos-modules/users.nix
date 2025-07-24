{ configs, username,... }:

{
  users = {
    users.${username} = {
      isNormalUser = true;
      description = "description";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
    };
    extraGroups.docker.members = [ username ];
  };
}
