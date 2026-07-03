{ config, pkgs, ... }@inputs:
{
  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      ""
      "/persistent/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      ""
      "systemd-machine-id-setup --commit --root /persistent"
    ];
  };
  preservation = {
    enable = true;
    preserveAt."/persist" = {
      directories = [
        # tmp can get large sometimes, will clear on boot separately
        {
          directory = "/tmp";
          mode = "0777";
        }
        # Logs
        "/var/log"
        "/var/lib/lastlog"
        # System state
        "/var/lib/nixos"
        {
          directory = "/etc/nixos";
          user = "v14";
          group = "users";
        }
        "/var/lib/systemd"
        "/var/lib/dhcpcd"
        # Application state
        "/etc/chromium"
        "/etc/firefox"
        "/var/lib/containers"
        "/var/lib/docker"
        "/var/lib/tailscale"
        # Networking state
        "/var/lib/bluetooth"
        "/var/lib/NetworkManager"
        "/etc/NetworkManager/system-connections"
        "/etc/bluetooth"
        # Caches not strictly necessary to preserve, but can speed up user experience
        "/var/cache/copyparty"
        "/var/cache/tailscale"
      ];
      files = [
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          mode = "0600";
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key.pub";
          mode = "0644";
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          mode = "0600";
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key.pub";
          mode = "0644";
        }
        {
          file = "/root/.config/sops/age/keys.txt";
          mode = "0600";
        }
        {
          file = "/etc/machine-id";
          how = "symlink";
          configureParent = true;
        }
      ];
      users.v14 = {
        directories = [
          # Standard user directories
          "Documents"
          "Downloads"
          "Music"
          "Pictures"
          "Videos"
          "Projects"
          "Mail"
          # Application data directories
          ".mozilla"
          ".config/mozilla"
          ".cache/mozilla"
          ".thunderbird"
          ".config/Bitwarden"
          ".config/chromium"
          ".config/Vencord"
          ".config/vesktop"
          ".config/github-copilot"
          ".config/kdeconnect"
          ".config/nautilus"
          ".config/noctalia"
          ".config/sops/age"
          ".config/zed"
          ".cache/zed"
          ".local/share/zed"
          ".local/share/keyrings"
          ".local/state/noctalia"
          ".cache/nix"
          ".cache/chromium"
          ".cache/noctalia"
          ".cache/noctalia-qs"
          ".cache/cliphist"
          ".cache/com.bitwarden.desktop"
        ];
        files = [
          { file = ".zsh_history"; }
          { file = ".zshrc"; }
          { file = ".ssh/known_hosts"; }
        ];
      };
    };
  };
}
