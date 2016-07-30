#!/bin/bash
# Script to stop the job server

get_abs_script_path() {
  pushd . >/dev/null
  cd "$(dirname "$0")"
  appdir=$(pwd)
  popd  >/dev/null
}

get_abs_script_path

if [ -f "$appdir/settings.sh" ]; then
  . "$appdir/settings.sh"
else
  echo "Missing $appdir/settings.sh, exiting"
  exit 1
fi

if [ ! -f "$PIDFILE" ] || ! kill -0 "$(cat "$PIDFILE")"; then
   echo 'Job server not running'
else
  echo 'Stopping job server...'
  PID="$(cat "$PIDFILE")"
  "$(dirname "$0")"/kill-process-tree.sh 15 $PID && rm "$PIDFILE"
  echo '...job server stopped'
fi
