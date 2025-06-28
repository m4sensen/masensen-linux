if [ -f "$codexBash_src" ]; then
  source "$codexBash_src"
else
  echo "Missing: $codexBash_src"
  echo "Exiting $frameworkName..."
  exit 1
fi