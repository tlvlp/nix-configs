# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{ 
    # TODO: 
    # - BT fix at startup
    # - zsh + nix terminal w/ nix config
    # - How to run RustRover and Intellij (flakes? or just give write access)
    # - How to install steam + gaming related drivers?
    # - Configure docker (maybe only for flakes?)
    # - Add Gruvbox dark medium theme to os

    # [ OS ] #######################################################################################

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
    # Programs
    programs.firefox.enable = true;
    # Run unpackaged programs
    # programs.nix-ld.enable = true;
    # programs.nix-ld.libraries = with pkgs; [
    #   # Dynamic libs come here.
    # ];
    # List packages installed in system profile. To search, run:
    # $ nix search wget
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
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };
    # Enable BT
    hardware.bluetooth.enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

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
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Enable networking
    networking.networkmanager.enable = true;
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
