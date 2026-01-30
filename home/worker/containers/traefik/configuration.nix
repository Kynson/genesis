{ socketEndpoint }: {
  api = {
    dashboard = true;
    insecure = true;
  };

  entryPoints.web.address = ":80";

  providers.docker = {
    endpoint = "unix://${socketEndpoint}";
    exposedByDefault = false;
  };
}