# util shortcuts ---

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias targz="tar -czf"
# alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias aptclean="apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"
alias test_tls_cert="openssl s_client -connect"
alias tf="terraform"
alias k="kubectl"
alias tmux-start="tmux new -As0"
alias ts="tmux-start"
alias vim="nvim"

get_tls_cert () {
    </dev/null openssl s_client -connect $HOST:$PORTNUMBER -servername $SERVERNAME \
    | openssl x509 > /tmp/$SERVERNAME.cert
    echo | openssl s_client -showcerts -servername gnupg.org -connect gnupg.org:443 2>/dev/null | openssl x509 -inform pem -noout -text
}

# docker commands --
alias dockernuke="docker system prune --volumes -f -a"
docker-get-tags () {
    if [[ "${1}" == */* ]]; then
        REPO="${1%%/*}";
        IMAGENAME="${1##*/}";
    else
        REPO="library";
        IMAGENAME="${1}";
    fi
    curl -s "https://registry.hub.docker.com/v2/repositories/${REPO}/${IMAGENAME}/tags?page_size=1000" | jq -r '.results[].name'
}

docker-get-tags-sizes () {
    curl -s https://hub.docker.com/v2/repositories/library/$1/tags/ | \
        jq '.results[] | select(.name=="latest") | .images[] | {architecture: .architecture, size: .size}'
}   

# git aliases ---
alias git-prune-local-branches='git fetch -p; git branch -vv | grep ": gone]" | grep -v "\*" | awk '"'"'{ print $1; }'"'"' | xargs -r git branch -D'
alias git-chmod-add-x='git update-index --chmod=+x'
alias git-chmod-sub-x='git update-index --chmod=-x'
alias git-ls-filemodes='git ls-files --stage'
alias git-lfs-reset='git lfs uninstall; git reset --hard; git lfs install; git lfs pull;'
alias git-lfs-hack-reset='git rm --cached -r . ; git reset --hard; git rm .gitattributes; git reset . ; git checkout .'
alias gc='git commit'
alias gst='git status'
alias gsh='git stash -u'
alias gp='git push'
alias gf='git fetch'

# docker apps ---
alias gomplate='docker run hairyhenderson/gomplate:stable'
alias run_pgsql="PGVERSION=${PGVERSION:-14} docker run -d --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=toortoor -v postgres_local_data:/var/lib/postgresql/data postgres:14"
alias pgloader="docker run --rm -it ghcr.io/dimitri/pgloader:latest pgloader"
alias openapi-generator="docker run --rm -v $(pwd):/local openapitools/openapi-generator-cli:latest"
alias bashly='docker run --rm -it --user $(id -u):$(id -g) -v "$(pwd):/app" dannyben/bashly:edge'
