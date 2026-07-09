{
  description = "drewofdoom's personal nix flake. modified from nnn-starter (https://github.com/floatdrop/nnn-starter/blob/main/README.md)";

  nixConfig = {
    extra-substituters = [
      "https://niri-epireyn.cachix.org"
    ];
    extra-trusted-public-keys = [
      "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    # Scrollable-tiling Wayland compositor + NixOS/home-manager modules.
    # Deliberately does NOT follow our nixpkgs, so niri-flake's prebuilt
    # packages stay byte-identical to what niri.cachix.org has cached.
    niri.url = "github:epireyn/niri-flake";

    # Dank DankMaterialShell
    dms.url = "github:AvengeMedia/DankMaterialShell/stable";
    dgop.url = "github:AvengeMedia/dgop";

    # System-wide base16 theming.
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pro audio
    musnix  = { url = "github:musnix/musnix"; };

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
      dms,
      stylix,
      nix-flatpak,
      ...
    } @ inputs: let
      hostSystem = "x86_64-linux";

      local = import ./local.nix;
      inherit (local) username;

      devSystems = [
        "x86_64-linux"
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
            nix-flatpak.nixosModules.nix-flatpak
            niri.nixosModules.niri
            stylix.nixosModules.stylix
            inputs.musnix.nixosModules.musnix
            home-manager.nixosModules.home-manager

            ./hosts/${hostname}
            ./modules/nixos

            {
              nixpkgs.config.allowUnfree = true;
              nixpkgs.config.allowInsecurePredicate = pkg: nixpkgs.lib.getName pkg == "pnpm";
              nixpkgs.overlays = [
                niri.overlays.niri
                (import ./overlays/yabridge-git.nix)
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-bak";
              home-manager.extraSpecialArgs = {inherit inputs username local hostname;};
              home-manager.sharedModules = [
                inputs.nix-flatpak.homeManagerModules.nix-flatpak
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
