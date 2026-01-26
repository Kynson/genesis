{
  services.coredns = {
    enable = true;
    config = ''
      . {
        health 0.0.0.0:5353

        cache

        template IN A 0x4b5354.dev {
          match ^(.+[.])?(?P<a>[0-9]{1,3})[.](?P<b>[0-9]{1,3})[.](?P<c>[0-9]{1,3})[.](?P<d>[0-9]{1,3})[.]0x4b5354[.]dev[.]$
          answer "{{ .Name }} 60 IN A {{ .Group.a }}.{{ .Group.b }}.{{ .Group.c }}.{{ .Group.d }}"
          fallthrough
        }

        forward . 1.1.1.1 1.0.0.1 8.8.8.8
      }
    '';
  };

  # Security: This server is deployed without port forwarding and is not accessible from the internet.
  # This will only allow DNS queries and health checks from local network.
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 5353 ];
}