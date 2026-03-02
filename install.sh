#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
NO_CLOBBER=false

usage() {
    cat <<EOF
Usage: $(basename "$0") <target> [project-path] [--no-clobber]

Targets:
  home       Deploy global configs to ~/.claude/
  project    Deploy project configs to <project-path>/.claude/
  all        Deploy both (requires project-path)

Options:
  --no-clobber   Skip files that already exist at the destination

Examples:
  $(basename "$0") home
  $(basename "$0") project /path/to/myproject
  $(basename "$0") all /path/to/myproject --no-clobber
EOF
    exit 1
}

backup_dir() {
    local target="$1"
    if [ -d "$target" ]; then
        local backup="${target}.backup.${TIMESTAMP}"
        echo "  Backing up $target → $backup"
        cp -r "$target" "$backup"
    fi
}

copy_files() {
    local src="$1"
    local dest="$2"

    if [ "$NO_CLOBBER" = true ] && [ -d "$dest" ]; then
        # Copy only files that don't exist at destination
        find "$src" -type f | while read -r file; do
            local rel="${file#$src/}"
            local dest_file="$dest/$rel"
            if [ ! -f "$dest_file" ]; then
                mkdir -p "$(dirname "$dest_file")"
                cp "$file" "$dest_file"
                echo "  + $rel"
            else
                echo "  ~ $rel (exists, skipped)"
            fi
        done
    else
        mkdir -p "$dest"
        cp -r "$src"/* "$dest"/
        echo "  Copied $(find "$src" -type f | wc -l | tr -d ' ') files"
    fi
}

deploy_home() {
    local dest="$HOME/.claude"
    echo "Deploying global configs → $dest"
    backup_dir "$dest"
    copy_files "$SCRIPT_DIR/home" "$dest"
    echo "Done."
    echo ""
}

deploy_project() {
    local project_path="$1"
    if [ -z "$project_path" ]; then
        echo "Error: project path required"
        usage
    fi
    if [ ! -d "$project_path" ]; then
        echo "Error: $project_path does not exist"
        exit 1
    fi
    local dest="$project_path/.claude"
    echo "Deploying project configs → $dest"
    backup_dir "$dest"
    copy_files "$SCRIPT_DIR/project" "$dest"
    echo ""
    echo "Next steps:"
    echo "  1. Edit $dest/CLAUDE.md with your project details"
    echo "  2. Add '.claude/local.md' to .gitignore"
    echo "  3. Commit .claude/CLAUDE.md to git"
    echo "Done."
    echo ""
}

# Parse arguments
TARGET="${1:-}"
PROJECT_PATH="${2:-}"

for arg in "$@"; do
    if [ "$arg" = "--no-clobber" ]; then
        NO_CLOBBER=true
    fi
done

case "$TARGET" in
    home)
        deploy_home
        ;;
    project)
        deploy_project "$PROJECT_PATH"
        ;;
    all)
        deploy_home
        deploy_project "$PROJECT_PATH"
        ;;
    *)
        usage
        ;;
esac
