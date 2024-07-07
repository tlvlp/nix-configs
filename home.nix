{ config, pkgs, ... }:

{
    # User
    home.username = "tlvlp";
    home.homeDirectory = "/home/tlvlp";
    home.stateVersion = "24.05"; # RTFM before changing!

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages
    home.packages = with pkgs; [
        cowsay
        google-chrome
        signal-desktop
        #dev
        git
        jetbrains.rust-rover
        jetbrains.idea-community
        vscode
        docker
        #nix build
        nix-output-monitor
        nvd
        #theme
        sassc
        gtk-engine-murrine
        gnome.gnome-themes-extra
    ];

    # Theme
    gtk = {
        enable = true;
        theme.name = "Gruvbox-Dark";
        theme.package = gruvbox-gtk-theme;
    };

    # Git
    programs.git = {
        enable = true;
        userName = "Peter Veres";
        userEmail = "tllvllp@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
            safe.directory = "/etc/nixos";
        };
    };

    # Manage plain files. Stored in and and symlinked to the Nix store. 
    home.file = {};

    # Environment variables
    home.sessionVariables = {};

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
