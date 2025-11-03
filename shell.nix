with import <nixpkgs> {};
mkShell.override { stdenv = llvmPackages_19.stdenv; } {
    buildInputs = [
        (haskellPackages.ghcWithPackages (pkgs: with pkgs; [
            HUnit
        ]))
        csvkit
        elfutils
        gmp
        hlint
        libffi
        llvmPackages_19.lld
        numactl
        ormolu
    ];
    APPEND_LIBRARY_PATH = lib.makeLibraryPath [
        elfutils
        gmp
        libffi
        numactl
    ];
    shellHook = ''
        export LD_LIBRARY_PATH="$APPEND_LIBRARY_PATH:$LD_LIBRARY_PATH"
    '';
}
