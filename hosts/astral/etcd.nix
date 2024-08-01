{...}: {
  services.etcd = {
    enable = true;
    listenClientUrls = [
      "http://10.99.2.1:2379"
      "http://127.0.0.1:2379"
    ];
  };
}
