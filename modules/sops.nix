{...}: {
  sops.defaultSopsFile = ../secrets/common.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
}
