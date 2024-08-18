{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "fs.inotify.max_user_watches" = 1048576;
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
