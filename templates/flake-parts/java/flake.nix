{
  description = "Java project";

  inputs = {
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    nix2container.url = "github:nlewo/nix2container";
    nix2container.inputs.nixpkgs.follows = "nixpkgs";
    mk-shell-bin.url = "github:rrbutani/nix-mk-shell-bin";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ flake-parts, devenv-root, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # NOTE: Unfree packages
        # _module.args.pkgs = import inputs.nixpkgs {
        #   inherit system;
        #   config.allowUnfree = true;
        # };

        devenv.shells.default = {
          name = "Java project";
          languages.java = {
            enable = true;
            jdk.package = pkgs.jdk;
            gradle.enable = false;
            maven.enable = false;
          };
          git-hooks.hooks = {
            # Common
            actionlint =
              {
                enable = false;
                excludes = [ "docker-publish.yaml" ];
              };
            checkmake.enable = true;
          };

          packages = with pkgs; [
            # quarkus
          ];

          devenv.root =
            let
              devenvRootFileContent = builtins.readFile devenv-root.outPath;
            in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;
        };
      };
    };
}
