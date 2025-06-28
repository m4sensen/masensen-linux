import_required_colors() {
  local COLOR_FILE="$(dirname "$0")/accessories/colors.sh"
  for varname in "$@"; do
    line=$(grep -E "^${varname}=" "$COLOR_FILE")
    if [[ -n "$line" ]]; then
      eval "$line"
    else
      echo "⚠️  Color '${varname}' not found in $COLOR_FILE" >&2
    fi
  done
  # Always include RESET
  eval "$(grep -E '^RESET=' "$COLOR_FILE")"
}