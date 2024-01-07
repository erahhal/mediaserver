{ inputs, lib, ... }:

{
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    ./profiles/common.nix
  ];

  # --------------------------------------------------------------------------------------
  # File system
  # --------------------------------------------------------------------------------------

  # @TODO: Setup luks or some disk encryption (ZFS?)

  # --------------------------------------------------------------------------------------
  # Network
  # --------------------------------------------------------------------------------------

  # Prevent hanging when waiting for network to be up
  systemd.network.wait-online.anyInterface = true;
  ## @TODO: Any ramifications of this?
  systemd.network.wait-online.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # --------------------------------------------------------------------------------------
  # Device specific
  # --------------------------------------------------------------------------------------

  # @TODO: Make this UI configurable
  time.timeZone = "America/Los_Angeles";

  networking = {
    # @TODO: Make this UI configurable
    hostName = "mediaserver";
    useNetworkd = true;
    networkmanager = {
      enable = true;
    };
    wireless = {
      # Disable wpa_supplicant
      enable = false;
    };
  };

  # --------------------------------------------------------------------------------------
  # Hardware specific
  # --------------------------------------------------------------------------------------
}


