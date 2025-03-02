{
  description = "Python project";

  inputs = {
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:cachix/devenv-nixpkgs/rolling";
    devenv.url = "github:cachix/devenv";
    nixpkgs-python = {
      url = "github:cachix/nixpkgs-python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs@{ nixpkgs, flake-parts, devenv-root, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # NOTE: Unfree packages
        # _module.args.pkgs = import inputs.nixpkgs {
        #   inherit system;
        #   config.allowUnfree = true;
        # };

        devenv.shells.default = {
          name = "Python project";

          languages.python = {
            enable = true;
            version = "3.11.9";
            uv.enable = false;
            uv.sync.enable = false;
          };

          # NOTE: First do devenv shell
          # git-hooks.hooks = {
          #   actionlint =
          #     {
          #       enable = true;
          #       excludes = [ "docker-publish.yaml" ];
          #     };
          #   checkmake.enable = true;
          # };

          devenv.root =
            let
              devenvRootFileContent = builtins.readFile devenv-root.outPath;
            in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;

          packages = with pkgs; [
            # python
          ];

          # enterShell = ''
          #   export PYTHONPATH="$(pwd):$(pwd)/src/apps:$(pwd)"
          #
          #   if ! [[ -d ".venv" ]]; then
          #     uv venv
          #     source .devenv/state/venv/bin/activate
          #     uv pip sync
          #   elif [[ -d "pyproject.toml" ]]; then
          #     source .devenv/state/venv/bin/activate
          #     uv pip sync
          #   else
          #     source .devenv/state/venv/bin/activate
          #   fi
          # '';
        };
      };
    };
}
