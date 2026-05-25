{ config, pkgs, ... }@inputs:
{
  boot.tmp.cleanOnBoot = true;
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
          inInitrd = true;
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
          ".local/state/lazygit"
          ".config/Bitwarden"
          ".config/chromium"
          ".config/containers"
          ".config/easyeffects"
          ".config/gh"
          ".config/git"
          ".config/kdeconnect"
          ".config/lazygit"
          ".config/nautilus"
          ".config/noctalia"
          ".config/sops/age"
          ".config/solaar"
          ".config/zed"
          ".cache/zed"
          ".local/share/zed"
          ".local/share/keyrings"
          ".cache/nix"
          ".cache/chromium"
          ".cache/noctalia"
          ".cache/noctalia-qs"
          ".cache/cliphist"
          ".cache/com.bitwarden.desktop"
          ".cache/mozilla"
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
