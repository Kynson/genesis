{
  imports= [
    ./traefik
  ];

  # Enable Podman socket
  systemd.user.sockets.podman = {
    Unit = {
      Description = "Podman API Socket";
      Documentation = "man:podman-system-service(1)";
    };
    Socket = {
      ListenStream = "%t/podman/podman.sock";
      SocketMode = "0600";
    };
    Install.WantedBy = ["sockets.target"];
  };

  services.podman.enable = true;
}