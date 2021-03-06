{
  description = ''Basic calculator in Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."crowncalc-master".dir   = "master";
  inputs."crowncalc-master".owner = "nim-nix-pkgs";
  inputs."crowncalc-master".ref   = "master";
  inputs."crowncalc-master".repo  = "crowncalc";
  inputs."crowncalc-master".type  = "github";
  inputs."crowncalc-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."crowncalc-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}