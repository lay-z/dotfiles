function program_exists() {
    # TODO figure out why this and not `which`
  which "$1" >/dev/null 2>&1
}
