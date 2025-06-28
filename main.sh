frameworkName="codexBash"
echo -e "\e[1;38;2;125;211;252mStarting $frameworkName framework © Masensen\e[0m"

echo "Defining the project directory, codex-bash.cfg, init.sh"
projectDir="$(dirname "${0}")"
codexBashCfgFile="$projectDir/codexBash.cfg"
codexBashInitFile="$projectDir/config/codexBash_init.sh"
codexBash_colors=(RED_500 SKY_400 EMERALD_600)

# === Declaring parent functions === #

import_required_colors_parent() {
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

require_file_parent() {
  local file="$1"
  local description="${2:-Required file}"

  if [ -f "$file" ]; then
    source "$file"
  else
    echo "$description not found: $file"
    echo "Exiting CodexBox..."
    sleep 10
    exit 1
  fi
}

require_file_parent "$(dirname "$0")/accessories/emojis.sh"
require_file_parent "$(dirname "$0")/accessories/fontStyle.sh"
import_required_colors_parent "${codexBash_colors[@]}"

require_file_parent "$(dirname "$0")/functions/require_file.sh"
require_file_parent "$(dirname "$0")/functions/log.sh"

# === End === #

echo "Loading codex-bash.cfg"
require_file_parent $codexBashCfgFile

echo "$frameworkName initialization ..."

echo "Loading codexBash_init.sh"
require_file_parent $codexBashInitFile

echo "Starting $project_name"
echo -e "\e[1;38;5;117mStarting $project_name installer © Masensen\e[0m"

echo "Defining project_init.sh"
projectInitFile="$projectDir/config/project_init.sh"

echo "Loading project_init.sh"
require_file_parent $codexBashInitFile