{ configs, username, ... }:

{
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      "/home/${username}/.steam/root/compatibilitytools.d";
  };
}
