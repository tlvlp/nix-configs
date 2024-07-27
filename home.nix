{ config, pkgs, ... }:

{
    # User
    home.username = "tlvlp";
    home.homeDirectory = "/home/tlvlp";
    home.stateVersion = "24.05"; # RTFM before changing!

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Environment variables
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "google-chrome";
      TERMINAL = "alacritty";
      SHELL="zsh";
    };
    
    fonts.fontconfig.enable = true;

    # Packages
    home.packages = with pkgs; [
        # essential
        cowsay
        # comms
        google-chrome
        signal-desktop
        # dev
        jetbrains.rust-rover
        jetbrains.idea-community
        docker
        mc
        # zsh
        zsh-powerlevel10k
        meslo-lgs-nf
    ];

    programs.git = {
        enable = true;
        userName = "Peter Veres";
        userEmail = "tllvllp@gmail.com";
        extraConfig = {
            init.defaultBranch = "main";
            safe.directory = "/etc/nixos";
        };
    };
    
    programs.fzf = { # Fuzzy Finder
      enable = true;
      enableZshIntegration = true; # ctrl + r
      colors = {
        fg = "#ebdbb2"; bg = "#282828"; hl = "#fabd2f"; "fg+" = "#ebdbb2"; "bg+" = "#3c3836"; "hl+" = "#fabd2f";
        info = "#83a598"; prompt = "#bdae93"; spinner = "#fabd2f"; pointer = "#83a598"; marker = "#fe8019"; header = "#665c54";
      };
    };

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 5000;
      shellAliases = {
        ll = "ls -1halF --color";
        z = "zellij";
        c = "clear";
        hms = "home-manager switch";
      };
      initExtra = ''
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        zstyle ':completion:*' menu no
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' 
      '';
      # ZSH Plugin manager
      zplug = {
        enable = true;
        plugins = [
          { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ];}
          { name = "Aloxaf/fzf-tab";}
        ];
      };
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./themes;
          file = ".p10k.zsh";
        }
      ];
    };

    programs.zellij = { # Terminal multiplexer
      enable = true;
      # enableZshIntegration = true; # opens a zellij session on start
      settings = { theme = "gruvbox-dark";};
    };

    programs.alacritty = { # Terminal
      # https://alacritty.org/config-alacritty.html
      enable = true;
      settings.shell.program = "${pkgs.zsh}/bin/zsh";
      settings.colors = {
        # Colors (Gruvbox Material Medium Dark)
        primary = { background = "#282828"; foreground = "#d4be98"; };
        normal = {
          black = "#3c3836"; red = "#ea6962"; green = "#a9b665"; yellow = "#d8a657"; 
          blue = "#7daea3"; magenta = "#d3869b"; cyan = "#89b482"; white  = "#d4be98";
        };
        bright = {
          black = "#3c3836"; red = "#ea6962"; green = "#a9b665"; yellow = "#d8a657"; 
          blue = "#7daea3"; magenta = "#d3869b"; cyan = "#89b482"; white  = "#d4be98";
        };
      };
      settings.window.startup_mode = "Windowed";
      settings.window.dimensions = { columns = 150; lines = 40; };
      settings.window.opacity = 0.9;
      settings.window.blur = true;
      settings.font.size = 13;
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

    dconf.settings = {"org/gnome/desktop/interface" = {enable-hot-corners = false;};};

    # Manage plain files. Stored in and and symlinked to the Nix store. 
    home.file = {};

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}