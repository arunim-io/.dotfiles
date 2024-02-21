self: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl."vm.swappiness" = 10;
    supportedFilesystems = [ "ntfs" ];
  };
}
