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

        mc
        superfile
        nerdfonts

    ];

    # Gruvbox Theme
    gtk = {
        enable = true;
        theme.name = "Gruvbox-Dark-BL-GS";
        theme.package = pkgs.gruvbox-gtk-theme;
        gtk3.extraConfig = { Settings = "gtk-application-prefer-dark-theme = 1";};
        gtk4.extraConfig = { Settings = "gtk-application-prefer-dark-theme = 1";};
    };
    programs.vscode = {
      extensions = with pkgs.vscode-extensions; [
        jdinhlife.gruvbox
      ];
      userSettings = {
        "workbench.colorTheme" = "Gruvbox Light Hard";
      };
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
    home.sessionVariables = {NEW_VAR = "hello from var";};

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
