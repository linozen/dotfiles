{ config, lib, pkgs, ... }:

{
  # Configure Backups
  # See: https://christine.website/blog/borg-backup-2021-01-09
  # First, make BorgBase repo a known host
  programs.ssh.knownHosts = {
    borgbaseEd25519 = {
      hostNames = [ "oxti13j3.repo.borgbase.com" ];
      publicKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMS3185JdDy7ffnr0nLWqVy8FaAQeVh1QYUSiNpW5ESq";
    };
    borgbaseRsa = {
      hostNames = [ "oxti13j3.repo.borgbase.com" ];
      publicKey =
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwHsO5g7kAEpqcK4bpHCUKYV1cKCUNwVEVsDQyfj7N8L92E21n+aEhIX2Nh/kFs1W9D/pgsWQBAbco9e/ORuagHrO8hUQtbda5Z31PAo4eipwP17VQr5rF3seaJJNFV72v89PGwMOWQwvoJte+yngC6PYGKJ+w63SRtflihAmf4xa5Tci/f6jbX6t32m2F3bnephVzQO6anGXvGPR8QYQXzSu/27+LaKnLd2Kugb1Ytbo0+6kioa60HWejIZ/mCrCHXYpi0jAllaYEuAsTqFWf/OFUHrKWwRAJD0TV43O1++vLlxY85oQxIgc4oUbm93dXmDBssrTnqqq2jqonteUr";
    };
    borgbaseEdsaSha2Nistp256 = {
      hostNames = [ "oxti13j3.repo.borgbase.com" ];
      publicKey =
        "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOstKfBbwVOYQh3J7X4nzd6/VYgLfaucP9z5n4cpSzcZAOKGh6jH8e1mhQ4YupthlsdPKyFFZ3pKo4mTaRRuiJo=";
    };
  };
  services.borgbackup.jobs."borgbase" = {
    paths = [ "/home" "/persist" ];
    exclude = [
      # Large paths in /persist
      "/persist/var/lib/docker"
      "/persist/var/lib/libvirt"

      # Temporary files and caches in /home
      "/home/*/.cache"
      "/home/*/.compose-cache"
      "/home/*/cache2"
      "/home/*/Cache"
      "/home/*/.npm/_cacache"
      "/home/*/__pycache__"
      "/home/*/target"
      "/home/*/go/bin"
      "/home/*/go/pkg"
      "/home/*/node_modules"
      "/home/*/bower_components"
      "/home/*/_build"
      "/home/*/.tox"
      "/home/*/venv"
      "/home/*/.venv"
    ];
    repo = "oxti13j3@oxti13j3.repo.borgbase.com:repo";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /persist/borg/passphrase";
    };
    environment.BORG_RSH = "ssh -i /persist/borg/ssh_key";
    compression = "auto,lzma";
    startAt = "hourly";
    prune.keep = {
      within = "2d"; # Keep all archives from the last two days
      daily = 14;
      weekly = 4;
      monthly = -1; # Keep at least one archive for each month
    };
  };
}
