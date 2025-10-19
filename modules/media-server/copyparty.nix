{ config, pkgs, ... }@inputs:
let
  virtualHosts = import ../caddy/virtualHosts.nix inputs;
in
{
  config = inputs.lib.mkIf config.media-server.enable {
    services.copyparty = {
      enable = true;
      settings = {
        i = "0.0.0.0";
        p = 3923;
        rproxy = 1;
        j = 0; # number of cores to use (0 = all)
        no-crt = true;
        e2dsa = true; # search
        e2ts = true; # metadata search
        th-r-vips = "avif,exr,fit,fits,fts,gif,hdr,heic,heics,heif,heifs,jp2,jpeg,jpg,jpx,jxl,nii,pfm,pgm,png,ppm,svg,tif,tiff,webp,pdf"; # thumbnailing with vips
      };
      accounts = {
        admin.passwordFile = config.sops.secrets."copyparty-password".path;
      };
      volumes = {
        "/" = {
          path = "/mnt/media/library";
          access = {
            A = [ "admin" ];
          };
        };
      };
      package = (
        pkgs.copyparty.override {
          withThumbnails = true;
          withFastThumbnails = true;
          withFTP = false;
        }
      );
    };
    environment.systemPackages = [ pkgs.copyparty ];
    users.users.${config.name}.extraGroups = [ "copyparty" ];
    services.caddy.virtualHosts = (virtualHosts.mkLocalVirtualHost "copyparty" 3923);
  };
}
