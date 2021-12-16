#!/usr/bin/env bash
#
# Setup a new machine, assuming ... not a lot about it.
#

# Keys used for SSH
readonly GPG_KEY_URL="https://gianni.cubecubed.xyz/static/public-key.asc"
readonly GPG_KEY_FP="0D941BE2A2858FA00F34BF4F95BB8B37AD880C27"

readonly DOT_REPO="https://github.com/VolatileDream/dot-files.git"
readonly WORKBENCH_REPO="git@github.com:VolatileDream/workbench.git"

install(){
  # Easier to edit latter
  sudo apt install "$@"
}

gpg_setup() {
  # This should setup the keys correctly to ensure gpg-agent is willing to
  # use them when we connect via ssh. We need to import & ultimate-trust the
  # imported key.

  curl "$GPG_KEY" | gpg2 --import
  echo "${GPG_KEY_FP}:6:" | gpg2 --import-ownertrust

  # SSH might have have started an agent, we need to switch over to gpg.
  unset SSH_AGENT_SOCK

  gpgconf --kill all
  gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
}

setup() {
  readonly tempd=`mktemp --directory`
  install git curl
  install pcscd scdaemon gnupg2 gnupg-agent

  [[ -d "$HOME/bin" ]] || git clone "$DOT_REPO" "$HOME/bin/"
  # Reset the upstream because we'll be using ssh from now on.
  sed --in-place 's_https://github.com/_git@github.com:_g' "$HOME/bin/.git/config"

  gpg_setup

  # this is a good test.
  ssh git@github.com

  [[ -d "$HOME/workbench" ]] || git clone "$WORKBENCH_REPO" "$HOME/workbench"

  cd "$HOME/bin/" ; ./dot-init
  cd "$HOME/workbench" ; tup # tup should be built by dot-files.
}

set -o errexit -o errtrace -o pipefail -o nounset
setup

