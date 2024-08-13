{
  config,
  pkgs,
  ...
}: {
  networking.firewall.extraCommands = ''
    iptables -t nat -A POSTROUTING -s 192.168.0.0/16 -d 10.99.0.0/16 -j MASQUERADE
  '';

  services.nebula.networks."lycoreco" = {
    staticHostMap = {
      "10.99.2.1" = [
        "astral.jerrita.cn:4242"
      ];
    };
    lighthouses = ["10.99.2.1"];
  };
}
