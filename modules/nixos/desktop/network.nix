{
  services.netbird = {
    enable = true;
    clients.default.port = 51829;
  };

  networking = {
    networkmanager.enable = true;
    firewall.allowedUDPPorts = [ 51820 ];

    wireguard.interfaces.wg0 = {
      listenPort = 51820;
      ips = [ "10.0.0.1/32" ];
      generatePrivateKeyFile = true;
      privateKeyFile = "/etc/wireguard/wg0.key";
      peers = [
        {
          persistentKeepalive = 25;
          allowedIPs = [ "10.0.0.2/32" ];
          publicKey = "wMQ1z87JcQ/xgkGnJi3E7AfNBVHp+RXYqTGREkaorkw=";
        }
      ];
    };
  };
}
