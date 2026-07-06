{
  description = "nnn-starter — an opinionated NixOS starter for the NNN stack (NixOS + Niri + Noctalia)";

  nixConfig = {
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://niri-epireyn.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Scrollable-tiling Wayland compositor + NixOS/home-manager modules.
    # Deliberately does NOT follow our nixpkgs, so niri-flake's prebuilt
    # packages stay byte-identical to what niri.cachix.org has cached.
    niri.url = "github:epireyn/niri-flake";

    # Noctalia desktop shell (v5 line). Pinned to the `cachix` branch: upstream
    # force-pushes there only after a commit's package is built and pushed to
    # noctalia.cachix.org, so `packages.default` is guaranteed to be a cache hit
    # (no ~hour-long C++ source build). It tracks `main` (v5), just slightly
    # behind. Crucially we do NOT make it follow our nixpkgs — that would
    # rebuild it against a different nixpkgs and miss the cache.
    noctalia.url = "github:noctalia-dev/noctalia-shell/cachix";

    # System-wide base16 theming.
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen browser (not in nixpkgs). It's a repackaged binary (fixed-output
    # download + wrapFirefox), so following our nixpkgs is cheap and avoids a
    # duplicate nixpkgs in the closure.
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      # Its home-manager module reuses HM's firefox module, so share ours.
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
      nixpkgs,
      home-manager,
      niri,
      noctalia,
      stylix,
      ...
    } @ inputs: let
      hostSystem = "x86_64-linux";

      local = import ./local.nix;
      inherit (local) username;

      devSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs devSystems;
      pkgsFor = system: nixpkgs.legacyPackages.${system};

      # Build a nixosConfiguration for one host, given its hostname.
      # Assumes ./hosts/<hostname> exists with a default.nix (and usually
      # a hardware-configuration.nix imported from there).
      mkHost = hostname:
        nixpkgs.lib.nixosSystem {
          system = hostSystem;
          specialArgs = {inherit inputs username local hostname;};
          modules = [
            niri.nixosModules.niri
            noctalia.nixosModules.default
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager

            ./hosts/${hostname}
            ./modules/nixos

            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.allowInsecurePredicate = pkg: nixpkgs.lib.getName pkg == "pnpm";
              nixpkgs.overlays = [
                niri.overlays.niri
                noctalia.overlays.default
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = {inherit inputs username local hostname;};
              home-manager.sharedModules = [
                noctalia.homeModules.default
              ];
              home-manager.users.${username} = import ./modules/home;
            }
          ];
        };
    in {
      nixosConfigurations = {
        shephard = mkHost "shephard";
        blackstar = mkHost "blackstar";
      };

      formatter = forAllSystems (system: (pkgsFor system).alejandra);

      devShells = forAllSystems (system: {
        default = (pkgsFor system).mkShell {
          packages = with pkgsFor system; [
            alejandra
            statix
            deadnix
            nh
            nix-output-monitor
          ];
        };
      });
    };

}
