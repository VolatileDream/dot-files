#!/usr/bin/env bash

i3_setup() {
  # Single monitor default.
  read -d '' i3_set << EOF
    workspace 1; append_layout $HOME/.config/i3/layouts/term-obsidian.json;
    workspace 2; append_layout $HOME/.config/i3/layouts/firefox.json;
    workspace 3; append_layout $HOME/.config/i3/layouts/discord.json;
EOF

  i3-msg "${i3_set}"
}

start_programs() {
  x-server-config
  firefox &
  obsidian.AppImage &
  i3-sensible-terminal &
  discord &
  run_keybase &
  signal-desktop &
}

i3_setup && start_programs && i3-msg "workspace 1;"
