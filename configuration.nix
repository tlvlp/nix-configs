# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{ 
    # [ OS ] #######################################################################################
    
    system.stateVersion = "24.05"; # RTFM before changing!
    
    imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];
    
    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;
    
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # [ USERS / APPS ] ################################################################################

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.tlvlp = {
        isNormalUser = true;
        description = "tlvlp";
        extraGroups = [ "networkmanager" "wheel" ];
    };

    # Home manager
    home-manager = {
        # also pass inputs to home-manager modules
        extraSpecialArgs = { inherit inputs; };
        users = { "tlvlp" = import ./home.nix;};
    };

    # System Packages
    environment.systemPackages = with pkgs; [];


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

    # Configure keymap in X11
    services.xserver = {
        xkb.layout = "us";
        xkb.variant = "";
    };

    # [ Network ] #################################################################################

    networking.hostName = "nixos"; # Define your hostname.
    networking.networkmanager.enable = true;



}
