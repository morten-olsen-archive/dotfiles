#!/bin/bash

SNAPSHOT_LOCATION="$HOME/.config/snapshot"
SNAPSHOT_FILE="$SNAPSHOT_LOCATION/snap.txt"

CMD=$1; shift

dontContainsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 1; done
  return 0
}

function create_snapshot {
  mkdir -p "$SNAPSHOT_LOCATION"
  yay -Qe | awk '{print $1}' > "$SNAPSHOT_FILE"
  echo "Snapshot created in $SNAPSHOT_FILE"
}

function install_snapshot {
  IFS=$'\n' read -d '' -a TARGET <<< `cat $SNAPSHOT_FILE`
  IFS=$'\n' read -d '' -a CURRENT <<< $(yay -Qet | cut -d ' ' -f 1)

  for i in "${TARGET[@]}"
  do : 
    if dontContainsElement "$i" "${CURRENT[@]}"; then
      INSTALL="$INSTALL
$i"
    fi
  done
  for i in "${CURRENT[@]}"
  do : 
    if dontContainsElement "$i" "${TARGET[@]}"; then
      REMOVE="$REMOVE
$i"
    fi
  done
  [[ ! -z "$REMOVE" ]] && yay -Rsn - <<< $(echo "$REMOVE" | grep .)
  [[ ! -z "$INSTALL" ]] && yay -S - <<< $(echo "$INSTALL" | grep .)
  echo "Done!"
}

case "$CMD" in
  "create")
    create_snapshot
    ;;
  "install")
    install_snapshot
    ;;
  "edit")
    ${EDITOR:-nano} "$SNAPSHOT_FILE"
    ;;
  *)
    echo "Unknown command"
    ;;
esac
