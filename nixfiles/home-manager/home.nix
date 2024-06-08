{ config, lib, pkgs, ... }:

{
  imports = [ ./modules ./modules/nautilus-open-any-terminal.nix ];

  custom = {
    gnome = {
      enable = true;
      epiphany = false;
    };
    firefox.enable = true;
    firefox-gnome-theme = {
      enable = config.programs.firefox.enable;
      profiles = [ "default" ];
      theme = "maia";
    };
  };

  home = {
    homeDirectory = "/home/ashgoldofficial";
    keyboard.options = "caps:ctrl_modifier";
    language = {
      address = "ru_RU.UTF-8";
      base = "en_US.UTF-8";
      collate = "ru_RU.UTF-8";
      ctype = "en_US.UTF-8";
      measurement = "ru_RU.UTF-8";
      messages = "en_US.UTF-8";
      monetary = "ru_RU.UTF-8";
      name = "en_US.UTF-8";
      numeric = "en_US.UTF-8";
      paper = "ru_RU.UTF-8";
      telephone = "ru_RU.UTF-8";
      time = "en_US.UTF-8";
    };
    sessionVariables = {
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
      _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
    };
    stateVersion = "23.05";
    username = "ashgoldofficial";
  };

  programs = {
    home-manager.enable = true;

    lf = {
      enable = true;
      settings = {
        cursorpreviewfmt = "\\033[7;90m";
        drawbox = true;
        icons = true;
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];

      extraPackages = with pkgs; [
        clang-tools
        fd
        lua-language-server
        nil
        nodePackages.typescript-language-server
        python311Packages.python-lsp-server
        ripgrep
        rust-analyzer
        vscode-langservers-extracted
      ];
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      localVariables = {
        PROMPT = "%F{green}%n%f %F{blue}%~%f %# ";
      };
      shellAliases = {
        diff = "${pkgs.colordiff}";
        grep = "grep --color=auto";
        l = "clear";
        ls = "ls --color=auto";
        ll = "ls --color=auto -l";
        svi = "sudoedit --";
        venv = "source ./venv/bin/activate";
      };
      syntaxHighlighting.enable = true;
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
