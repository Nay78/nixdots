let
  # RTX 3070 Ti
  gpuIDs = [
    "10de:28e0" # Graphics
    "10de:22be" # Audio
  ];
in
{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.vfio.enable = with lib; mkEnableOption "Configure the machine for VFIO";

  config =
    let
      cfg = config.vfio;
    in
    {
      environment.systemPackages = with pkgs; [
        virt-manager
        looking-glass-client
        evsieve
        virtiofsd
      ];

      programs.dconf.enable = true;

      virtualisation.libvirtd = {
        enable = true;
        # qemu.ovmf.enable = true;
        # qemu.runAsRoot = false;
        qemu = {
          # enable = true;
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [
              (pkgs.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              }).fd
            ];
          };
        };

        # qemuOvmf = true;
        # qemuRunAsRoot = false;
        onBoot = "ignore";
        onShutdown = "shutdown";
      };

      systemd.tmpfiles.rules = [
        "f /dev/shm/looking-glass 0660 alejg qemu-libvirtd -"
        "f /dev/shm/looking-glass 0660 alejg kvm -"
      ];

      boot = {
        initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          # "vfio_virqfd"
          # vfio_virqfd

          # "nvidia"
          # "nvidia_modeset"
          # "nvidia_uvm"
          # "nvidia_drm"
        ];
        initrd.availableKernelModules = [
          "amdgpu"
          "vfio-pci"
        ];

        initrd.preDeviceCommands = ''
          DEVS="0000:01:00.0 0000:01:00.1"
          for DEV in $DEVS; do
            echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
          done
          modprobe -i vfio-pci
        '';

        kernelParams =
          [
            # enable IOMMU
            "amd_iommu=on"
          ]
          ++ lib.optional cfg.enable
            # isolate the GPU
            ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };

      # hardware.opengl.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };
}
