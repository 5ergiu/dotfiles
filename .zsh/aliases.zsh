# ============================================================================
# Kubernetes, Helm, Docker & Custom scripts aliases
# ============================================================================

alias help='showhelp'

# Brew (Homebrew package manager)
alias b='brew'
alias bi='brew install'
alias bu='brew update'
alias bup='brew upgrade'
alias bdl='brew list'
alias brm='brew uninstall'
alias bsearch='brew search'
alias binfo='brew info'

# Yadm (dotfiles manager)
alias y='yadm'
alias ya='yadm add'
alias yc='yadm commit -m'
alias yp='yadm push'
alias ypl='yadm pull'
alias yst='yadm status'
alias yd='yadm decrypt'
alias ye='yadm encrypt'
alias yls='yadm list'
alias ydiff='yadm diff'

# Editors
alias vim='nvim'

# Eza (ls replacement)
alias ls='eza --icons --git'
alias ll='eza --icons --git -l'
alias la='eza --icons --git -la'
alias tree='eza --icons --git --tree'

# Bat (cat and less replacement)
alias cat='bat --paging=never'
alias less='bat --paging=always'

# Fd (find replacement)
alias find='fd'

# Ansible
alias a='ansible'
alias al='ansible-lint'
alias ap='ansible-playbook'

# Terraform
alias tf='terraform'

# Basic kubectl shortcuts
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kgi='kubectl get ingress'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'

# Kubectl with namespace
alias kgpn='kubectl get pods -n'
alias kgsn='kubectl get svc -n'
alias kgdn='kubectl get deployments -n'

# Describe resources
alias kdp='kubectl describe pod'
alias kds='kubectl describe svc'
alias kdd='kubectl describe deployment'

# Logs
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias klp='kubectl logs --previous'

# Exec into pod
alias kex='kubectl exec -it'
alias ksh='kubectl exec -it -- sh'
alias kbash='kubectl exec -it -- bash'

# Delete resources
alias kdel='kubectl delete'
alias kdelp='kubectl delete pod'
alias kdelf='kubectl delete -f'

# Apply and create
alias ka='kubectl apply -f'
alias kc='kubectl create -f'

# Port forwarding
alias kpf='kubectl port-forward'

# Get all resources in all namespaces
alias kgaa='kubectl get all --all-namespaces'

# Get pod by label
alias kgpl='kubectl get pods -l'

# Watch pods
alias kwp='watch kubectl get pods'

# Helm aliases
alias h='helm'
alias hls='helm list'
alias hlsa='helm list --all-namespaces'
alias hi='helm install'
alias hu='helm upgrade'
alias hui='helm upgrade --install'
alias hdel='helm delete'
alias hs='helm status'
alias hget='helm get values'
alias ht='helm template'
alias htest='helm test'

# Helmfile aliases
alias hf='helmfile'
alias hfa='helmfile apply'
alias hfs='helmfile sync'
alias hfd='helmfile diff'
alias hfb='helmfile build'
alias hfl='helmfile list'
alias hft='helmfile template'
alias hfdel='helmfile destroy'

# Docker aliases
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'
alias dl='docker logs'
alias dlf='docker logs -f'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'
alias dinspect='docker inspect'
alias dprune='docker system prune -a'
alias db='docker build'
alias dr='docker run'
alias drit='docker run -it'

# Docker Compose aliases
alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcupf='docker-compose up -d --force-recreate'
alias dcdown='docker-compose down'
alias dcps='docker-compose ps'
alias dclogs='docker-compose logs'
alias dclogsf='docker-compose logs -f'
alias dcrestart='docker-compose restart'
alias dcstop='docker-compose stop'
alias dcstart='docker-compose start'
alias dcbuild='docker-compose build'
alias dcpull='docker-compose pull'
alias dcexec='docker-compose exec'

# Git aliases
alias "?"='git status'
alias "??"='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gb='git branch'
alias gba='git branch -a'
alias gr='git remote -v'

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Show all available custom commands
showhelp() {
    local category="${1:-all}"
    category=$(echo "$category" | tr '[:upper:]' '[:lower:]')
    
    # Normalize category aliases
    case "$category" in
        k|k8s|kube) category="kubernetes" ;;
        h|helm|helmfile) category="helm" ;;
        d|dc|docker|docker-compose) category="docker" ;;
        g|git) category="git" ;;
        custom) category="custom" ;;
    esac
    
    # Header
    if [ "$category" = "all" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🛠️  Kubernetes, Helm, Docker & Custom Scripts - Helper Commands"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "💡 Tip: Use 'help <category>' to filter commands"
        echo "   Categories: kubernetes|k8s, helm, docker, custom"
        echo ""
    fi

    # Brew section
    if [ "$category" = "all" ] || [ "$category" = "brew" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🍺 HOMEBREW"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "📋 Brew Aliases:"
        echo "  b           - brew"
        echo "  bi          - brew install"
        echo "  bu          - brew update"
        echo "  bup         - brew upgrade"
        echo "  bdl         - brew list"
        echo "  brm         - brew uninstall"
        echo "  bsearch     - brew search"
        echo "  binfo       - brew info"
        echo ""
    fi

    # Yadm section
    if [ "$category" = "all" ] || [ "$category" = "yadm" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📦 YADM (Dotfiles Manager)"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "📋 Yadm Aliases:"
        echo "  y           - yadm"
        echo "  ya          - yadm add"
        echo "  yc          - yadm commit -m"
        echo "  yp          - yadm push"
        echo "  ypl         - yadm pull"
        echo "  yst         - yadm status"
        echo "  yd          - yadm decrypt"
        echo "  ye          - yadm encrypt"
        echo "  yls         - yadm list"
        echo "  ydiff       - yadm diff"
        echo ""
        echo "🔧 Helper Functions:"
        echo "  ybackup     - Encrypt all changes and push to remote"
        echo ""
    fi
    
    # Kubernetes section
    if [ "$category" = "all" ] || [ "$category" = "kubernetes" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "☸️  KUBERNETES"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "� Aliases:"
        echo "  k                - kubectl"
        echo "  kgp              - kubectl get pods"
        echo "  kgs              - kubectl get svc"
        echo "  kgd              - kubectl get deployments"
        echo "  kgi              - kubectl get ingress"
        echo "  kgn              - kubectl get nodes"
        echo "  kga              - kubectl get all"
        echo "  kgpn             - kubectl get pods -n <namespace>"
        echo "  kl               - kubectl logs"
        echo "  klf              - kubectl logs -f"
        echo "  kex              - kubectl exec -it"
        echo "  ksh              - kubectl exec -it -- sh"
        echo "  kdel             - kubectl delete"
        echo "  ka               - kubectl apply -f"
        echo "  kpf              - kubectl port-forward"
        echo "  kwp              - watch kubectl get pods"
        echo ""
        echo "🔧 Functions:"
        echo "  klogs <app> [ns]              - Get logs by app name"
        echo "  kexec <app> [ns] [shell]      - Exec into pod by app name"
        echo "  kforward <app> <ports> [ns]   - Port forward by app name (e.g., 3000:3000)"
        echo "  krestart <deployment> [ns]    - Restart deployment"
        echo "  kwatch [ns]                   - Watch pod status in real-time"
        echo "  klogall <app> [ns]            - Get all container logs for an app"
        echo "  kgetall                       - Get all pods with IPs and nodes"
        echo ""
    fi
    
    # Helm section
    if [ "$category" = "all" ] || [ "$category" = "helm" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "⎈  HELM & HELMFILE"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "📋 Helm Aliases:"
        echo "  h                - helm"
        echo "  hls              - helm list"
        echo "  hlsa             - helm list --all-namespaces"
        echo "  hi               - helm install"
        echo "  hu               - helm upgrade"
        echo "  hui              - helm upgrade --install"
        echo "  hdel             - helm delete"
        echo "  hs               - helm status"
        echo "  hget             - helm get values"
        echo "  ht               - helm template"
        echo ""
        echo "📋 Helmfile Aliases:"
        echo "  hf               - helmfile"
        echo "  hfa              - helmfile apply"
        echo "  hfs              - helmfile sync"
        echo "  hfd              - helmfile diff"
        echo "  hfb              - helmfile build"
        echo "  hfl              - helmfile list"
        echo "  hft              - helmfile template"
        echo "  hfdel            - helmfile destroy"
        echo ""
        echo "🔧 Functions:"
        echo "  hup <release> <chart> [ns]       - Upgrade/install release"
        echo "  hdiff <release> <chart> [ns]     - Show diff before upgrade"
        echo ""
    fi
    
    # Docker section
    if [ "$category" = "all" ] || [ "$category" = "docker" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🐳 DOCKER & DOCKER COMPOSE"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "📋 Docker Aliases:"
        echo "  d                - docker"
        echo "  dps              - docker ps"
        echo "  dpsa             - docker ps -a"
        echo "  di               - docker images"
        echo "  drm              - docker rm"
        echo "  drmi             - docker rmi"
        echo "  dex              - docker exec -it"
        echo "  dl               - docker logs"
        echo "  dlf              - docker logs -f"
        echo "  dstop            - docker stop"
        echo "  db               - docker build"
        echo "  dr               - docker run"
        echo ""
        echo "📋 Docker Compose Aliases:"
        echo "  dc               - docker-compose"
        echo "  dcup             - docker-compose up -d"
        echo "  dcupf            - docker-compose up -d --force-recreate"
        echo "  dcdown           - docker-compose down"
        echo "  dcps             - docker-compose ps"
        echo "  dclogs           - docker-compose logs"
        echo "  dclogsf          - docker-compose logs -f"
        echo "  dcrestart        - docker-compose restart"
        echo "  dcbuild          - docker-compose build"
        echo "  dcexec           - docker-compose exec"
        echo ""
        echo "🔧 Functions:"
        echo "  dshell <container>            - Exec into container (auto detects shell)"
        echo "  dstopall                      - Stop all running containers"
        echo "  drmall                        - Remove all stopped containers"
        echo "  drmdangling                   - Remove all dangling images"
        echo ""
    fi
    
    # Git section
    if [ "$category" = "all" ] || [ "$category" = "git" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🔄 GIT"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "📋 Git Aliases:"
        echo "  ?                - git status"
        echo "  ??               - git diff"
        echo "  ga               - git add"
        echo "  gc               - git commit -m"
        echo "  gp               - git push"
        echo "  gb               - git branch"
        echo "  gba              - git branch -a"
        echo "  gr               - git remote -v"
        echo ""
        echo "🔧 Functions:"
        echo "  gac <message>                 - Git add all and commit with message"
        echo ""
    fi
    
    if [ "$category" = "all" ]; then
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    fi
}

# Display help on load
echo "✅ Kubernetes, Helm, Docker & Custom scripts aliases and Helper Functions loaded!"
echo "💡 Type 'help' to see all available commands or 'help <category>' for specific ones"
