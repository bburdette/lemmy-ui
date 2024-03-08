{
  description = "package dependencies for dev environment on nixos";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        # Specify a version of nodejs if needed

        # buildNodeJs = pkgs.callPackage "${nixpkgs}/pkgs/development/web/nodejs/nodejs.nix" {
        #   python = pkgs.python3;
        # };

        # nodejs = buildNodeJs {
        #   enableNpm = true;
        #   version = "16.16.0";
        #   sha256 = "FFFR7/Oyql6+czhACcUicag3QK5oepPJjGKM19UnNus=";
        # };
      in
      rec {
        flakedPkgs = pkgs;

        # enables use of `nix shell`
        devShell = pkgs.mkShell {
          # add things you want in your shell here
          buildInputs = with pkgs; [
            nodejs_20
            typescript

            # needed for nx.  for here?
            # libuuid
          ];

          # add to shellhook for libuuid
          #   export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath [pkgs.libuuid]};
          shellHook = ''
            export PATH=$PATH:"$(pwd)/node_modules/.bin"
          '';
        };
      }
    );
}
