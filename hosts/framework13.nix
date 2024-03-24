{ config, lib, pkgs, modulesPath, system, home-manager, ...}:

{
  imports = [
    ../system
    ../system/gpu.nix
    ../system/swap.nix
    ../system/media.nix
    ../system/power.nix

    ../system/firewall.nix
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

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault system.arch;
  hardware.cpu.amd.updateMicrocode = true;
  
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usb", ATTR{power/wakeup}="enabled"
  '';
  
  services.power-profiles-daemon.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "framework13";

  time.timeZone = "Europe/London";

  users.groups.mtburge = {};
  users.users.mtburge = {
    isNormalUser = true;
    group = "mtburge";
    initialPassword = "changeme";
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [];
  };

  environment.systemPackages = with pkgs; [
    vim
    kitty
    wget
    tree
    htop
    neofetch
  ];

  networking.firewall.allowedTCPPorts = [
    57621 #spotify
  ];

  networking.firewall.allowedUDPPorts = [
    5353 #spotify
  ];
  
  system.stateVersion = "23.11";
}
