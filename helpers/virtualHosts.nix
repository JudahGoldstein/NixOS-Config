inputs:
let
  inherit (inputs) lib;
  mkLocalVirtualHost = name: port: {
    "${name}.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
    "${name}.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };

  mkPublicVirtualHost = name: port: {
    "${name}.local.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
    "${name}.ts.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
    "${name}.wan.janjuta.org" = {
      useACMEHost = "janjuta.org";
      extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString port}
      '';
    };
  };
in
{
  inherit mkLocalVirtualHost mkPublicVirtualHost;
}
