{
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    # "/swap".options = [ "noatime" ];
  };

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  # services.beesd.filesystems = {
  #   root = {
  #     spec = "LABEL=root";
  #     hashTableSizeMB = 2048;
  #     verbosity = "crit";
  #     extraOptions = [ "--loadavg-target" "5.0" ];
  #   };
  # };
}