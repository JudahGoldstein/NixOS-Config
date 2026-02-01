{ config, pkgs, ... }@inputs:
{
  services.copyparty = {
    enable = true;
    group = "media";
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
      "/TTRPGs/" = {
        path = "/mnt/media/library";
        access = {
          A = [ "admin" ];
          r = [ "*" ];
        };
      };
      "/Forge/" = {
        path = "${config.services.sd-webui-forge.dataDir}/log/images/";
        access = {
          A = [ "admin" ];
        };
      };
      "/Uploads/" = {
        path = "/mnt/media/copyparty-uploads";
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
  services.caddy.virtualHosts = (inputs.virtualHosts.mkLocalVirtualHost "copyparty" 3923);
}
