# ============================================================================
# DOCKER HELPER FUNCTIONS
# ============================================================================

# Stop all running containers
dstopall() {
    docker stop $(docker ps -q)
}

# Remove all stopped containers
drmall() {
    docker rm $(docker ps -a -q)
}

# Remove all dangling images
drmdangling() {
    docker rmi $(docker images -f "dangling=true" -q)
}

# Docker exec with automatic shell detection
dshell() {
    if [ -z "$1" ]; then
        echo "Usage: dshell <container-name-or-id>"
        return 1
    fi
    
    if docker exec -it "$1" bash 2>/dev/null; then
        return 0
    else
        docker exec -it "$1" sh
    fi
}
