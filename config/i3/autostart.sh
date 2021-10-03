#!/usr/bin/env bash

i3_setup() {
  read -d '' i3_set << EOF
    workspace 1; append_layout $HOME/.config/i3/layouts/term-disks.json;
    workspace 2; append_layout $HOME/.config/i3/layouts/firefox.json;
    workspace 5; append_layout $HOME/.config/i3/layouts/discord.json;
    workspace 6; append_layout $HOME/.config/i3/layouts/steam.json;
EOF

  i3-msg "${i3_set}"
}

start_programs() {
  firefox &
  lxterminal &
  lxterminal &
  gnome-disks &
  discord &
  run_keybase &
  # steam-wrapper &
}

i3_setup && start_programs && i3-msg "workspace 1;"
