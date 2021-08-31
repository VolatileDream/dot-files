#!/usr/bin/env bash

i3_setup() {
  # Setup all the screens.
  # Remember that workspaces 1 to n exist, where n is the number of monitors.
  # Swap them to n + 99 so we can remap the workspaces
  read -d '' i3_reset << EOF
  workspace 1;
  workspace 100;
  workspace 2;
  workspace 101;
EOF

  # Go to specific monitors and swap around the workspaces.
  read -d '' i3_set << EOF
  focus output DP-4;
    workspace 1; append_layout $HOME/.config/i3/term-disks.json;
    workspace 2; append_layout $HOME/.config/i3/firefox.json;
  focus output HDMI-0;
    workspace 5; append_layout $HOME/.config/i3/discord.json;
    workspace 6; append_layout $HOME/.config/i3/steam.json;
EOF

  i3-msg "${i3_reset}" && i3-msg "${i3_set}"
}

start_programs() {
  firefox &
  lxterminal &
  lxterminal &
  gnome-disks &
  discord &
  run_keybase &
  # steam &
}

i3_setup && start_programs && i3-msg "workspace 1;"
