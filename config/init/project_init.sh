if [ -f "$main_menuFile" ]; then
  source "$main_menuFile"
else
  echo "Missing: $main_menuFile"
  echo "Exiting $frameworkName..."
  exit 1
fi