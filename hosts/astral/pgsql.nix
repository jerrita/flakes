{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [5432];
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    enableJIT = true;
    enableTCPIP = true;

    initialScript = pkgs.writeText "init-sql-script" ''
      alter user postgres with password 'Str@ngPa5swOrd';
    '';

    authentication = ''
      host all all 0.0.0.0/0 md5
    '';
  };
}
