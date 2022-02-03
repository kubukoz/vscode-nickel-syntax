{ mkYarnPackage, gitignore-source, tree }:
let
  pname = "nickel-syntax";
  version = (builtins.fromJSON (builtins.readFile ./package.json)).version;
  name = "${pname}-${version}.vsix";
in
mkYarnPackage {
  inherit name;
  src = gitignore-source.lib.gitignoreSource ./.;

  nativeBuildInputs = [ tree ];
  buildPhase = ''
    cd deps/nickel-syntax
    rm nickel-syntax #some weird link
    tree
    yarn --offline vsce package --yarn
  '';

  installPhase = ''
    ls -alG
    mv ${name} $out
  '';

  distPhase = "true";
}
