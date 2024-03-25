{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.walker.packages.${pkgs.system}.walker
    pkgs.fzf
  ];

  home.file.".config/walker/config.json".text = ''
    {
      "placeholder": "Search...",
      "keep_open": false,
      "notify_on_fail": true,
      "enable_typeahead": false,
      "show_initial_entries": true,
      "fullscreen": false,
      "activation_mode": {
        "disabled": false,
        "use_alt": false
      },
      "search": {
        "delay": 0,
        "hide_icons": false,
        "margin_spinner": 10
      },
      "runner": {
        "excludes": ["rm"]
      },
      "clipboard": {
        "max_entries": 10,
        "image_height": 300
      },
      "align": {
        "width": 400,
        "horizontal": "center",
        "vertical": "start",
        "margins": {
          "top": 20,
          "bottom": 0,
          "end": 0,
          "start": 0
        }
      },
      "list": {
        "height": 300,
        "margin_top": 10,
        "always_show": true
      },
      "orientation": "vertical",
      "icons": {
        "hide": false,
        "size": 28,
        "image_height": 200
      },
      "modules": [
        {
          "name": "runner",
          "prefix": ""
        },
        {
          "name": "applications",
          "prefix": ""
        },
        {
          "name": "ssh",
          "prefix": "",
          "switcher_exclusive": true
        },
        {
          "name": "finder",
          "prefix": "",
          "switcher_exclusive": true
        },
        {
          "name": "commands",
          "prefix": "",
          "switcher_exclusive": true
        },
        {
          "name": "websearch",
          "prefix": "?"
        },
        {
          "name": "switcher",
          "prefix": "/"
        }
      ]
    }
  '';

  home.file.".config/walker/style.css".text = ''
    * {
      color: #dcd7ba;
    } 

    #window {}

    #box {
      background: #16161d;
      padding: 10px;
      border-radius: 2px;
    }

    #search,
    #typeahead {
      border-radius: 0;
      outline: none;
      outline-width: 0px;
      box-shadow: none;
      border-bottom: none;
      border: none;
      background: #1f1f28;
      padding-left: 10px;
      padding-right: 10px;
      padding-top: 0px;
      padding-bottom: 0px;
      border-radius: 2px;
    }

    #typeahead {
      background: none;
      opacity: 0.5;
    }

    #search placeholder {
      opacity: 0.5;
    }

    #list {}

    #list *:selected {
      background: #1f1f28;
    }

    .item {
      padding: 5px;
      border-radius: 2px;
    }

    .icon {
      padding-right: 5px;
    }

    .textwrapper {
    }

    .label {
    }

    .sub {
      opacity: 0.5;
    }

    .activationlabel {
      opacity: 0.25;
    }

    .activation .activationlabel {
      opacity: 1;
      color: #76946a;
    }

    .activation .textwrapper,
    .activation .icon,
    .activation .search {
      opacity: 0.5;
    }

  '';
}
