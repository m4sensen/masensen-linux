log "What would you like to do ?"






if [ -f "$project_src" ]; then
  source "$project_src"
else
  echo "Missing: $project_src"
  echo "Exiting $frameworkName..."
  exit 1
fi