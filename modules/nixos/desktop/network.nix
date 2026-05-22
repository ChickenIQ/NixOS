{ pkgs, ... }:
{
  services.netbird = {
    enable = true;
    clients.default.port = 51829;
    package = pkgs.unstable.netbird;
  };

  networking = {
    useDHCP = false;
    dhcpcd.enable = false;
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

  systemd.services.NetworkManager-wait-online.enable = false;
}
