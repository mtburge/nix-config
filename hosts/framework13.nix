{ config, lib, pkgs, modulesPath, system, home-manager, ...}:

{
  imports = [
    ../system
    ../system/gpu.nix
    ../system/swap.nix
    ../system/media.nix
    ../system/power.nix
    ../system/udev.nix
    ../system/network.nix
    ../system/polkit.nix
    ../system/greetd.nix
    ../system/1password.nix
  ];
  
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "mem_sleep_default=deep" "resume_offset=104388608" ];
  boot.kernelPackages = pkgs.linuxPackages_6_8;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.initrd.luks.devices."nixos".device = "/dev/disk/by-partlabel/root";
  boot.resumeDevice = "/dev/dm-0"; 
  
  hardware.cpu.amd.updateMicrocode = true;
  
  fileSystems = {
    "/" = {
      device = "/dev/mapper/nixos";
      fsType = "ext4";
    };
    
    "/boot" = {
      device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
    };
  };

  swapDevices = [
    {
      device = lib.mkForce "/var/swapfile";
      label = "swap";
      size = 34816;
      priority = 0;
    }
  ];

  users.groups.mtburge = {};
  users.users.mtburge = {
    isNormalUser = true;
    group = "mtburge";
    initialPassword = "changeme";
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [];

  networking.firewall.allowedTCPPorts = [
    57621 #spotify
  ];

  networking.firewall.allowedUDPPorts = [
    5353 #spotify
  ];
  
  system.stateVersion = "23.11";
}
