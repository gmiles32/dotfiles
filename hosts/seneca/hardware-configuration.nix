{ config, pkgs, ... }: {
  # Kernel
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Partitions
  fileSystems."/" = {   
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };
      
  swapDevices = [ ];
 
  # Extra configuration
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true; 
}
