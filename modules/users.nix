# User configurations

{ config, ... }: {
  # Admin user
  users.users.kynsonszetau = {
    description = "Kynson Szetau";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    uid = 1000;
    hashedPasswordFile = config.sops.secrets.kynsonszetauHashedPassword.path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJYC8kogSSE2oSeb/Jl+Z4ykwgWh5o8f0TYtaTTXcsP+"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7ymvpLQkiDquPwUVLg42iFbw+WSoFX7Qb14NCCZmsfqKK/X45SwRZ98kAyFji+Jvb7lquBm9YxoQB7kknXzdKqfgrYwJpLCUwq5mw9wfkmORz1QLfbdvQf8qDG12Rlbjm8CQH2PBqDW6FJqqpv7nA6pC5PZ6KzblOWRWE+Re+Y2tmi8d7TZMNHT7UKm168BjM45wRWNgFyTVtkRFYS5WOf6A/9ihZO/QS001VvBQGsNN2UTZyjhk7eFf0NXXlVyqpPYf7j7676hHwCraD1K3rFmLeZwn3yQDzrxYERDh1XfIR2JqfFyXxnxdMGZMYPbf+t8SdU6y4Yro+JUYqLNI9cLp07Qw6qX81y0lejEMjSE+8bITPKXuqy7JVtPSjN8sgOl8BXeJOO5MEHwLm5uA4TY/EXQ4cFUToX4oljxk4eVHcrAyENYSrDq1K4atXoEpthfnzm5FldsPaB30eoNItXPxyomfzWa4hNvX/3dt8ODE6InM/ZX4h1kggZzvupQGaWit5ESG8Lokw58fueHtcQ4wmbKdko4TanqBOziexoiZV0MkmxJ+H0xARRXvj/DOsKu33Ui4qW29MokncXc1x3hfVRsvgd0rTG8MDoz95f0ToUhz08S7H05WEE4msvHD5RJg4wI7yc/NW6L6DATt0FKh4EmbeYu5RETKG8ZrYGw=="
    ];
  };

  # Worker user
  users.users.genesis = {
    description = "Genesis Containers Worker";
    isNormalUser = true;
    uid = 1001;
    # Enable lingering to allow user units to be started at boot
    linger = true;
  };
}