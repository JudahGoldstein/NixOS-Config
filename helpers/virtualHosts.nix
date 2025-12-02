inputs:
let
  inherit (inputs) lib;
  mkVirtualHost = domains: port: lib.genAttrs domains (domain: {
    useACMEHost = "janjuta.org";
    extraConfig = ''
      reverse_proxy http://127.0.0.1:${toString port}
    '';
  });

  mkLocalVirtualHost = name: port: mkVirtualHost [
    "${name}.local.janjuta.org"
    "${name}.ts.janjuta.org"
  ] port;

  mkPublicVirtualHost = name: port: mkVirtualHost [
    "${name}.local.janjuta.org"
    "${name}.ts.janjuta.org"
    "${name}.wan.janjuta.org"
  ] port;
in
{
  inherit mkLocalVirtualHost mkPublicVirtualHost;
}
