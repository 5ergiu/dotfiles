# ============================================================================
# HELM HELPER FUNCTIONS
# ============================================================================

# Helm upgrade with automatic install
hup() {
    if [ -z "$2" ]; then
        echo "Usage: hup <release-name> <chart> [namespace] [--set flags...]"
        return 1
    fi
    
    local release="$1"
    local chart="$2"
    local ns="${3:-default}"
    shift 3
    
    helm upgrade --install "$release" "$chart" --namespace "$ns" --create-namespace "$@"
}

# Helm diff (requires helm-diff plugin)
hdiff() {
    if [ -z "$2" ]; then
        echo "Usage: hdiff <release-name> <chart> [namespace]"
        return 1
    fi
    
    local release="$1"
    local chart="$2"
    local ns="${3:-default}"
    
    helm diff upgrade "$release" "$chart" --namespace "$ns"
}
