function program_exists() {
    # TODO figure out why this and not `which`
    hash $1 2>/dev/null
}
