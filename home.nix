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
        jetbrains.rust-rover
        jetbrains.idea-community
        docker

        mc

    ];

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
    };

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vscode/extensions/default.nix
        # nix
        bbenoist.nix

        # git
        donjayamanne.githistory
        eamodio.gitlens

        # general
        davidanson.vscode-markdownlint
        k--kato.intellij-idea-keybindings

        # theme
        jdinhlife.gruvbox
      ];
      userSettings = {
        "workbench.colorTheme" = "Gruvbox Dark Medium";
        "explorer.confirmDelete" = false;
        "git.enableSmartCommit" = true;

      };
    };

    programs.git = {
        enable = true;
        userName = "Peter Veres";
        userEmail = "tllvllp@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
            safe.directory = "/etc/nixos";
        };
    };

    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      theme = "Gruvbox Dark";
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        # TODO Add plugins
      ];
    };


    gtk = {
      enable = true;
      theme.name = "Gruvbox-Dark-BL-GS";
      theme.package = pkgs.gruvbox-gtk-theme;
      gtk3.extraConfig = { Settings = "gtk-application-prefer-dark-theme = 1";};
      gtk4.extraConfig = { Settings = "gtk-application-prefer-dark-theme = 1";};
    };

    # Manage plain files. Stored in and and symlinked to the Nix store. 
    home.file = {};

    # Environment variables
    home.sessionVariables = {
      NEW_VAR = "hello from var";
      EDITOR = "nvim";
      BROWSER = "google-chrome";
      TERMINAL = "kitty";
      SHELL="zsh";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}