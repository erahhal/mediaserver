{ lib, pkgs, ... }:
let
  device-name = "mediaserver";
  bitrate = "320";
  cache-args = "--disable-audio-cache";
  # cache-args = "--cache /var/cache/raspotify";
  volume-args = "--enable-volume-normalisation --volume-ctrl=linear --initial-volume=100";
  backend-args = "--backend alsa";
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
        PermissionsStartOnly = true;
        Restart = "always";
        RestartSec = 10;
        ExecStart = "${pkgs.librespot}/bin/librespot --name '${device-name}' ${backend-args} --bitrate ${bitrate} ${cache-args} ${volume-args}";
      };
    };
  };

  system.activationScripts.makeSpotifyConnectCacheDir = lib.stringAfter [ "var" ] ''
    mkdir -p /var/cache/spotify-connect
  '';
}

