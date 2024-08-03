{config, ...}: let
  user = config.systemd.services.etcd.serviceConfig.User;
in {
  sops.secrets = {
    "etcd/ca.crt".owner = user;
    "etcd/cert.pem".owner = user;
    "etcd/key.pem".owner = user;
  };

  systemd.services.etcd = {
    wants = ["sops-nix.service"];
    after = ["sops-nix.service"];
  };

  services.etcd = {
    enable = true;
    listenClientUrls = [
      "https://0.0.0.0:2379"
    ];
    trustedCaFile = config.sops.secrets."etcd/ca.crt".path;
    clientCertAuth = true;
    openFirewall = true;
    certFile = config.sops.secrets."etcd/cert.pem".path;
    keyFile = config.sops.secrets."etcd/key.pem".path;
  };
}
