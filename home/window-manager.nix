{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      "$wallpaper" = "${config.xdg.dataHome}/wallpapers/bespinian.png";
      "$lockCmd" = "${pkgs.swaylock}/bin/swaylock --daemonize";
      "$sleepCmd" = "systemctl suspend";
      "$launcherCmd" = "${pkgs.fuzzel}/bin/fuzzel --prompt 'Run '";
      general = {
        border_size = 2;
        gaps_in = 0;
        gaps_out = 0;
        "col.active_border" = "rgb(bb9af7)";
        cursor_inactive_timeout = 8;
      };
      input = {
        kb_options = "caps:escape,compose:ralt";
        touchpad.natural_scroll = true;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_min_speed_to_force = 5;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      dwindle = {
        # Put new splits on the right/bottom
        force_split = 2;
        no_gaps_when_only = true;
      };
      monitor = "eDP-1,preferred,auto,1.5";
      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.gammastep}/bin/gammastep"
        "${pkgs.swayidle}/bin/swayidle -w timeout 900 '$lockCmd' timeout 1200 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' timeout 1800 '$sleepCmd' before-sleep 'playerctl pause' before-sleep '$lockCmd' lock '$lockCmd'"
        "${pkgs.swaybg}/bin/swaybg --image $wallpaper --mode fill"
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store --max-items 20"
      ];
      bind = [
        # Window manager
        "$mainMod, Tab, focusurgentorlast"
        "$mainMod, Q, killactive"
        "$mainMod, F, fullscreen"
        "$mainMod, S, togglefloating"

        # Shortcuts
        "$mainMod, Space, exec, $launcherCmd"
        "$mainMod, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "$mainMod, W, exec, ${pkgs.brave}/bin/brave"
        "$mainMod, C, exec, ${pkgs.cliphist}/bin/cliphist list | ${pkgs.fuzzel}/bin/fuzzel --dmenu --prompt 'Copy ' | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"
        "SUPER_CTRL, Q, exec, $lockCmd"

        # Media keys
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}playerctl previous"
        ", XF86Search, exec, $launcherCmd"

        # Screenshots
        ", Print ,exec, ${pkgs.grim}/bin/grim ${config.xdg.userDirs.download}/screenshot-$(date +'%F-%H-%M-%S').png"
        "$mainMod, Print , exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" ${config.xdg.userDirs.download}/screenshot-$(date +'%F-%H-%M-%S').png"

        # Move window focus
        "$mainMod, H, movefocus, l"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"
        "$mainMod, L, movefocus, r"

        # Switch workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, togglespecialworkspace"
        "$mainMod, N, workspace, empty"

        # Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, special"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  programs = {
    # Status bar
    waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "custom/tasks" ];
          modules-right = [
            "custom/updates"
            "custom/containers"
            "wireplumber"
            "bluetooth"
            "network"
            "battery"
            "clock"
          ];
          battery = {
            states = {
              warning = 20;
              critical = 1;
            };
            format = "<span size=\"96%\">{icon}</span>";
            format-icons = {
              default = [ "󰁺" "󰁻" "󰁼" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
              charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
              critical = [ "󱃍" ];
            };
            tooltip-format = "Battery at {capacity}%";
          };
          clock = {
            format = "{:%a %d %b %H:%M}";
            tooltip-format = "<big>{:%B %Y}</big>\n\n<tt><small>{calendar}</small></tt>";
          };
          network = {
            format-ethernet = "󰈀";
            format-wifi = "{icon}";
            format-linked = "󰈀";
            format-disconnected = "󰖪";
            format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
            tooltip-format-wifi = "{essid} at {signalStrength}%";
          };
          wireplumber = {
            format = "<span size=\"120%\">{icon}</span>";
            format-muted = "<span size=\"120%\">󰸈</span>";
            format-icons = [ "󰕿" "󰖀" "󰕾" ];
            tooltip-format = "Volume at {volume}%";
          };
          bluetooth = {
            format = "";
            format-on = "<span size=\"105%\">󰂯</span>";
            format-connected = "<span size=\"105%\">󰂱</span>";
            tooltip-format-on = "Bluetooth {status}";
            tooltip-format-connected = "Connected to {device_alias}";
          };
          "custom/tasks" = {
            exec = pkgs.writeShellScript "waybar-tasks" ''
              set -u

              if [ ! -x "$(command -v task)" ]; then
              	exit 1
              fi

              active_task=$(task rc.verbose=nothing rc.report.activedesc.filter=+ACTIVE rc.report.activedesc.columns:description rc.report.activedesc.sort:urgency- rc.report.activedesc.columns:description activedesc limit:1 | head -n 1)
              if [ -n "$active_task" ]; then
              	echo "󰐌 $active_task"
              	exit 0
              fi

              ready_task=$(task rc.verbose=nothing rc.report.readydesc.filter=+READY rc.report.readydesc.columns:description rc.report.readydesc.sort:urgency- rc.report.readydesc.columns:description readydesc limit:1 | head -n 1)
              if [ -z "$ready_task" ]; then
              	echo ""
              	exit 0
              fi

              echo "󰳟 $ready_task"
            '';
            exec-if = "which task";
            interval = 60;
          };
          "custom/containers" = {
            exec = pkgs.writeShellScript "waybar-containers" ''
              set -u

              if [ ! -x "$(command -v podman)" ]; then
              	exit 1
              fi

              running_container_count=$(podman ps --noheading | wc -l)

              if [ "$running_container_count" -eq 0 ]; then
              	echo ""
              exit 0
              fi

              suffix=""
              if [ "$running_container_count" -gt 1 ]; then
                suffix = "s"
              fi

              echo "{\"text\": \"󰡨\", \"tooltip\": \"$running_container_count container$suffix running\"}"
            '';
            exec-if = "which podman";
            interval = 60;
            return-type = "json";
          };
          "custom/updates" = {
            format = "<span size=\"120%\">{}</span>";
            exec = pkgs.writeShellScript "waybar-updates" ''
              set -u

              current_timestamp=$(nix flake metadata ~/.nixfiles --json | jq '.locks.nodes.nixpkgs.locked.lastModified')
              latest_timestamp=$(nix flake metadata github:NixOS/nixpkgs/nixos-unstable --json | jq '.locked.lastModified')

              if [ "$latest_timestamp" -le "$current_timestamp" ]; then
                echo ""
                exit 0
              fi

              echo "{\"text\": \"󱄅\", \"tooltip\": \"Updates available\"}"
            '';
            exec-if = "test -d ~/.nixfiles";
            interval = 21600; # 6h
            return-type = "json";
          };
        };
      };
      style = ''
        /* General */
        * {
            border-radius: 0;
            font-family: "FiraCode Nerd Font";
            font-size: 13px;
            color: #c0caf5;
          }

          window#waybar {
            background-color: #1a1b26;
          }

          tooltip {
            background-color: #15161e;
          }

          /* Workspaces */
          #workspaces button {
            margin: 4px;
            padding: 0 8px;
            border-radius: 9999px;
          }

          #workspaces button:hover {
            border-color: transparent;
            box-shadow: none;
            background: #414868;
          }

          #workspaces button.active {
            padding: 0 13px;
            background: #2f334d;
          }

          /* Modules */
          #clock,
          #network,
          #wireplumber,
          #bluetooth,
          #battery,
          #custom-updates,
          #custom-tasks,
          #custom-containers,
          #mode {
            margin: 4px;
            padding: 0 13px;
            border-radius: 9999px;
            background-color: #2f334d;
          }

          #network {
            padding: 0 15px 0 11px;
          }

          #mode,
          #custom-updates {
            color: #bb9af7;
            font-weight: bold;
            padding: 0 15px 0 12px;
          }

          #battery.critical {
            color: #f7768e;
            font-weight: bold;
          }
      '';
    };

    # Launcher
    fuzzel = {
      enable = true;
      settings = {
        main = {
          width = 70;
          horizontal-pad = 10;
          vertical-pad = 10;
          inner-pad = 10;
          line-height = 25;
        };
        colors = {
          background = "1a1b26ff";
          text = "c0caf5ff";
          match = "ffffffff";
          selection = "bb9af7ff";
          selection-text = "ffffffff";
          selection-match = "1a1b26ff";
        };
        border.radius = 0;
      };
    };

    # Lock screen manager
    swaylock = {
      enable = true;
      settings = {
        image = "${config.xdg.dataHome}/wallpapers/bespinian.png";
      };
    };
  };

  services = {
    # Notification daemon
    mako = {
      enable = true;
      font = "FiraCode Nerd Font 9";
      backgroundColor = "#1a1b26";
      textColor = "#c0caf5";
      borderColor = "#bb9af7";
      defaultTimeout = 8000;
      groupBy = "app-name,summary";
    };

    # Adjust color temperature to reduce eye strain
    gammastep = {
      enable = true;
      provider = "geoclue2";
    };
  };

  # Fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    fira-mono
    fira-code-nerdfont
    lato
  ];

  # Wallpaper
  xdg.dataFile = {
    "wallpapers/bespinian.png".source = ./wallpapers/bespinian.png;
  };
}
