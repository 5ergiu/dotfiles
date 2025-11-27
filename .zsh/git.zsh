# ============================================================================
# GIT HELPER FUNCTIONS
# ============================================================================

# Git add all and commit with message
gac() {
    if [ -z "$1" ]; then
        echo "Usage: gac <commit-message>"
        return 1
    fi

    git add .
    git commit -m "$1"
}
