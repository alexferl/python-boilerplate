#!/bin/bash
set -euo pipefail

if [[ $# -eq 0 ]]; then
	echo "Usage: $0 <app_name> [additional_args...]" >&2
	exit 1
fi

log() {
	local type="$1"; shift
	# accept argument string or stdin
	local text="$*"; if [ "$#" -eq 0 ]; then text="$(cat)"; fi
	local dt; dt="$(date "+%Y-%m-%d %H:%M:%S")"
	printf '%s [%s] [Entrypoint]: %s\n' "$dt" "$type" "$text"
}

info() {
	log Info "$@"
}

APP_NAME=${1:-"app.main"}
shift

info "Starting application: $APP_NAME"

case "$APP_NAME" in
  app.*)
    CMD="python -m $APP_NAME $*"
    ;;
  *)
    CMD="$APP_NAME $*"
    ;;
esac

info "Executing command: $CMD"
exec $CMD
