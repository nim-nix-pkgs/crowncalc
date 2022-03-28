{
  description = ''Basic calculator in Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-crowncalc-master.flake = false;
  inputs.src-crowncalc-master.ref   = "refs/heads/master";
  inputs.src-crowncalc-master.owner = "RainbowAsteroids";
  inputs.src-crowncalc-master.repo  = "crowncalc";
  inputs.src-crowncalc-master.type  = "github";
  
  inputs."noise".owner = "nim-nix-pkgs";
  inputs."noise".ref   = "master";
  inputs."noise".repo  = "noise";
  inputs."noise".dir   = "v0_1_14";
  inputs."noise".type  = "github";
  inputs."noise".inputs.nixpkgs.follows = "nixpkgs";
  inputs."noise".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."sdl2".owner = "nim-nix-pkgs";
  inputs."sdl2".ref   = "master";
  inputs."sdl2".repo  = "sdl2";
  inputs."sdl2".dir   = "v2_0_3";
  inputs."sdl2".type  = "github";
  inputs."sdl2".inputs.nixpkgs.follows = "nixpkgs";
  inputs."sdl2".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-crowncalc-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-crowncalc-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}