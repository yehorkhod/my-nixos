1. Enable Flakes;
2. Create nix shell with git and copy this repo;
3. Change `hardware-configuration.nix` file with yours;
4. Rebuild you system `sudo nixos-rebuild switch --flake ~/System#lemon`;
5. Vist **Home Manager Manual** and read standalone installation part;
6. Install home-manager;
7. Run: `home-manager switch --flake ./System/`;
8. You're good to go!

# Games
After installing OS, run `protonup`.

If game has problems with resolution, screen size, upscaling, etc, run:

```bash
gamesscope ...
```

To monitor stuff, run:

```bash
mangohud ...
```

To improve performance, run:

```bash
gamemoderun ...
```
