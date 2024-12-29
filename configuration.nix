# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{ 
    # [ OS ] ######################################################################################
    
    imports =
    [ # Include the results of the hardware scan.
        /etc/nixos/hardware-configuration.nix
    ];
       
    system.stateVersion = "24.05"; # RTFM before changing!

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;
        videoDrivers = [ "amdgpu" ];
        xkb.layout = "us";
        xkb.variant = "";
        # Enable the GNOME Desktop Environment.
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
    };

    hardware = {
        graphics.enable = true;
    };


    # [ USERS / APPS ] ################################################################################

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.tlvlp = {
        isNormalUser = true;
        description = "tlvlp";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Install packages
    environment.systemPackages = with pkgs; [ 
        git 
	home-manager
        mesa
	mesa-demos
	vulkan-loader
	vulkan-tools
	#llvmPackages
    ];


    # [ PERIPHERIALS ] #########################################################################

    # Enable CUPS to print documents.
    services.printing.enable = true;
    
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Enable BT
    hardware.bluetooth.enable = true;


    # [ LANGUAGE / LOCALE ] ######################################################################

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";
    
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "nl_NL.UTF-8";
        LC_IDENTIFICATION = "nl_NL.UTF-8";
        LC_MEASUREMENT = "nl_NL.UTF-8";
        LC_MONETARY = "nl_NL.UTF-8";
        LC_NAME = "nl_NL.UTF-8";
        LC_NUMERIC = "nl_NL.UTF-8";
        LC_PAPER = "nl_NL.UTF-8";
        LC_TELEPHONE = "nl_NL.UTF-8";
        LC_TIME = "en_GB.UTF-8";
    };


    # [ Network ] #################################################################################

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;



}
