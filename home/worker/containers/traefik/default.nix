{ pkgs, workerUid, ... }:
let 
  hostSocketEndpoint = "/run/user/${toString workerUid}/podman/podman.sock";
  containerSocketEndpoint = "/var/run/podman.sock";

  traefikConfig = (pkgs.formats.yaml {}).generate
    "traefik.yaml"
    (import ./configuration.nix {
      socketEndpoint = containerSocketEndpoint;
    });
in 
{
 services.podman.containers.traefik = {
    description = "Local services traefik reverse proxy";
    image = "traefik";
    ports = [
      # Port forwarding is done via nftables 
      "8080:80"
      "8081:8080" 
    ];
    volumes = [
      "${hostSocketEndpoint}:${containerSocketEndpoint}:ro"
      "${traefikConfig}:/etc/traefik/traefik.yaml"
    ];
    network = "traefik";

    autoStart = true;
  };

  services.podman.networks.traefik = {
    description = "Shared network for local services and traefik reverse proxy";
    driver = "bridge";
  };
}