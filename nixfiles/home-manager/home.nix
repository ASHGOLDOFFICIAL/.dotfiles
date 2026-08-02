{ config, lib, pkgs, ... }:

{
  imports = [ ./modules ];

  custom = {
    gnome.enable = true;
    firefox.enable = true;
    firefox-gnome-theme = {
      enable = false;
      profiles = [ "default" ];
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

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
    sessionVariables = {
      ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
      ESDE_APPDATA_DIR = "${config.xdg.configHome}/ES-DE";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
      WINEPREFIX = "${config.xdg.dataHome}/wine";
      XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    };
    stateVersion = "23.05";
    username = "ashgoldofficial";
  };

  programs = {
    git = {
      enable = true;
      settings.user = {
        core.compression = 0;
        email = "104313094+ASHGOLDOFFICIAL@users.noreply.github.com";
        http.postBuffer = 524288000;
        name = "Andrey Shaat";
      };
    };

    home-manager.enable = true;

    lf = {
      enable = true;
      settings = {
        cursorpreviewfmt = "\\033[7;90m";
        drawbox = true;
        icons = true;
      };
    };

#    neovim = {
#      enable = true;
#      defaultEditor = true;
#      viAlias = true;
#      vimAlias = true;
#      withPython3 = false;
#      withRuby = false;
#      extraPackages = with pkgs; [
#        clang-tools
#        fd
#        lua-language-server
#        nil
#        python314Packages.python-lsp-server
#        ripgrep
#        rust-analyzer
#        vscode-langservers-extracted
#      ];
#    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
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
      setSessionVariables = true;

      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      projects = "${config.home.homeDirectory}/projects";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
  };
}
