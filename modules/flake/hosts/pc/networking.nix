{
  flake.hosts."pc" = {
    systemd.network.links."10-lan" = {
      matchConfig.Path = "pci-0000:0c:00.0";
      linkConfig = {
        Name = "lan";
        WakeOnLan = "magic";
      };
    };

    networking = {
      firewall.allowedUDPPorts = [
        51820
        9
      ];

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

    persistence.files = [
      {
        file = "/etc/wireguard/wg0.key";
        mode = "0600";
      }
    ];
  };
}
