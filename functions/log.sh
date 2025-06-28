log() {
  echo -e "[LOG]  $(date +'%Y-%m-%d %H:%M:%S')  $*"
}

logSuccess() {
  echo -e "${GREEN}${EMOJI_SUCCESS} [SUCCESS] $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logWarn() {
  echo -e "${YELLOW}${EMOJI_WARN}  [WARN]  $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logError() {
  echo -e "${RED}${EMOJI_ERROR} [ERROR] $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}" >&2
}

logDebug() {
  echo -e "${BLUE}${EMOJI_DEBUG} [DEBUG] $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logQuestion() {
  echo -e "${PURPLE}${EMOJI_QUESTION} [QUESTION] $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logWait() {
  echo -e "${CYAN}⏳ [WAIT]    $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logClean() {
  echo -e "${GREEN}🧹 [CLEAN]   $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logSecure() {
  echo -e "${BLUE}🔐 [SECURE]  $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logSave() {
  echo -e "${GREEN}💾 [SAVE]    $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logCheck() {
  echo -e "${BLUE}🔎 [CHECK]   $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logUpload() {
  echo -e "${CYAN}📤 [UPLOAD]  $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}

logDownload() {
  echo -e "${CYAN}📥 [DOWNLOAD] $(date +'%Y-%m-%d %H:%M:%S')  $*${NC}"
}
