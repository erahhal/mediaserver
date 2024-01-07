README
======

Raspberry Pi Media Server

### Dev Environment Setup

Must have the following in your host nix config to cross compile:

```
{
  # Enable binfmt emulation of aarch64-linux.
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
```
