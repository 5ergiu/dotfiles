# ============================================================================
# KUBERNETES HELPER FUNCTIONS
# ============================================================================

# Watch pod status in real-time
kwatch() {
    local ns="${1:-default}"
    watch -n 1 "kubectl get pods -n $ns -o wide"
}

# Get pod logs by app name
klogs() {
    if [ -z "$1" ]; then
        echo "Usage: klogs <app-name> [namespace]"
        return 1
    fi
    
    local app="$1"
    local ns="${2:-default}"
    
    kubectl logs -n "$ns" -l "app.kubernetes.io/name=$app" -f
}

# Exec into pod by app name
kexec() {
    if [ -z "$1" ]; then
        echo "Usage: kexec <app-name> [namespace] [shell]"
        return 1
    fi
    
    local app="$1"
    local ns="${2:-default}"
    local shell="${3:-sh}"
    
    local pod=$(kubectl get pod -n "$ns" -l "app.kubernetes.io/name=$app" -o jsonpath='{.items[0].metadata.name}')
    
    if [ -z "$pod" ]; then
        echo "No pod found for app: $app in namespace: $ns"
        return 1
    fi
    
    kubectl exec -it -n "$ns" "$pod" -- "$shell"
}

# Port forward by app name
kforward() {
    if [ -z "$2" ]; then
        echo "Usage: kforward <app-name> <local-port:remote-port> [namespace]"
        return 1
    fi
    
    local app="$1"
    local ports="$2"
    local ns="${3:-default}"
    
    local pod=$(kubectl get pod -n "$ns" -l "app.kubernetes.io/name=$app" -o jsonpath='{.items[0].metadata.name}')
    
    if [ -z "$pod" ]; then
        echo "No pod found for app: $app in namespace: $ns"
        return 1
    fi
    
    kubectl port-forward -n "$ns" "$pod" "$ports"
}

# Restart deployment by name
krestart() {
    if [ -z "$1" ]; then
        echo "Usage: krestart <deployment-name> [namespace]"
        return 1
    fi
    
    local deploy="$1"
    local ns="${2:-default}"
    
    kubectl rollout restart deployment -n "$ns" "$deploy"
}

# Get all pods with their IPs and nodes
kgetall() {
    kubectl get pods --all-namespaces -o wide
}
