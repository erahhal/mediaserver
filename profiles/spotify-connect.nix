{ lib, pkgs, ... }:
let
  device-name = "mediaserver";
  bitrate = "320";
  cache-args = "--disable-audio-cache";
  # cache-args = "--cache /var/cache/raspotify";
  volume-args = "--enable-volume-normalisation --volume-ctrl=linear --initial-volume=100";
  backend-args = "--backend=alsa";
  zeroconf-args = "--zeroconf-port=5353";
  ## Allows for seeing device across the internet
  # options = "--username <USERNAME> --password <PASSWORD>";
in
{
  systemd.services = {
    spotify-connect = {
      description = "Spotify Connect Daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = "mediaserver";
	Group = "users";
        PermissionsStartOnly = true;
        Restart = "always";
        RestartSec = 10;
        ExecStart = "${pkgs.librespot}/bin/librespot --name '${device-name}' ${zeroconf-args} ${backend-args} --bitrate ${bitrate} ${cache-args} ${volume-args} --verbose";
      };
    };
  };

  system.activationScripts.makeSpotifyConnectCacheDir = lib.stringAfter [ "var" ] ''
    mkdir -p /var/cache/spotify-connect
  '';

  networking.firewall.allowedUDPPorts = [ 5353 ];
  networking.firewall.allowedTCPPorts = [ 5353 ];
}

