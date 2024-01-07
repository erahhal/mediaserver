{ lib, ... }:
{
  # Deals with compilation error
  # https://github.com/NixOS/nixpkgs/issues/154163
  nixpkgs = {
    overlays = [
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // { allowMissing = true; });
      })
    ];
  };
}
