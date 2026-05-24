{ config, pkgs, ... }@inputs:
{
  boot.tmp.cleanOnBoot = true;
  preservation = {
    enable = true;
    preserveAt."/persist" = {
      directories = [
        # tmp can get large sometimes, will clear on boot separately
        "/tmp"
        # Logs
        "/var/log"
        "/var/lib/lastlog"
        # System state
        "/var/lib/nixos"
        "/etc/nixos"
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
        { file = "/etc/ssh/ssh_host_ed25519_key"; }
        { file = "/etc/ssh/ssh_host_ed25519_key.pub"; }
        { file = "/etc/ssh/ssh_host_rsa_key"; }
        { file = "/etc/ssh/ssh_host_rsa_key.pub"; }
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
          ".mozzila"
          ".thunderbird"
          ".local/state/lazygit"
          ".config/Bitwarden"
          ".config/chromium"
          ".config/containers"
          ".config/Discord"
          ".config/discord"
          ".config/easyeffects"
          ".config/gh"
          ".config/git"
          ".config/kdeconnect"
          ".config/lazygit"
          ".config/nautilus"
          ".config/noctalia"
          ".config/obsidian"
          ".config/obs-studio"
          ".config/sops"
          ".config/solaar"
          ".config/teams-for-linux"
          ".config/Vencord"
          ".config/vesktop"
          ".config/zed"
          # Caches not strictly necessary to preserve, but can speed up user experience
          ".cache/nix"
          ".cache/chromium"
          ".cache/mozilla"
          ".cache/noctalia"
          ".cache/noctalia-qs"
          ".cache/zed"
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
