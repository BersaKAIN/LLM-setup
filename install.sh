#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
NO_CLOBBER=false

usage() {
    cat <<EOF
Usage: $(basename "$0") <target> [project-path] [--no-clobber]

Targets:
  home       Deploy global configs: symlink skills + copy Claude Code configs
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

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        local backup="${target}.backup.${TIMESTAMP}"
        echo "  Backing up $target → $backup"
        cp -r "$target" "$backup"
    fi
}

link_skills() {
    local target_dir="$1"
    shift

    mkdir -p "$target_dir"

    for source_dir in "$@"; do
        [ -d "$source_dir" ] || continue
        for skill in "$source_dir"/*/; do
            [ -d "$skill" ] || continue
            local skill_name
            skill_name="$(basename "$skill")"
            local dest="$target_dir/$skill_name"

            if [ "$NO_CLOBBER" = true ] && [ -e "$dest" ]; then
                echo "  ~ $skill_name (exists, skipped)"
            else
                ln -sfn "$skill" "$dest"
                echo "  + $skill_name → $skill"
            fi
        done
    done
}

copy_files() {
    local src="$1"
    local dest="$2"

    if [ "$NO_CLOBBER" = true ] && [ -d "$dest" ]; then
        find "$src" -type f | while read -r file; do
            local rel="${file#"$src"/}"
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
    echo "=== Linking skills ==="

    echo ""
    echo "Cursor (~/.cursor/skills/) ← shared + cursor-only"
    link_skills "$HOME/.cursor/skills" \
        "$SCRIPT_DIR/skills/shared" \
        "$SCRIPT_DIR/skills/cursor-only"

    echo ""
    echo "Claude Code (~/.claude/skills/) ← shared + claude-only"
    link_skills "$HOME/.claude/skills" \
        "$SCRIPT_DIR/skills/shared" \
        "$SCRIPT_DIR/skills/claude-only"

    echo ""
    echo "=== Copying Claude Code configs → ~/.claude/ ==="
    local claude_dir="$HOME/.claude"

    for item in CLAUDE.md settings.json; do
        local src="$SCRIPT_DIR/home/$item"
        local dest="$claude_dir/$item"
        [ -f "$src" ] || continue
        if [ "$NO_CLOBBER" = true ] && [ -f "$dest" ]; then
            echo "  ~ $item (exists, skipped)"
        else
            backup_if_exists "$dest"
            mkdir -p "$claude_dir"
            cp "$src" "$dest"
            echo "  + $item"
        fi
    done

    for dir in agents commands; do
        local src="$SCRIPT_DIR/home/$dir"
        local dest="$claude_dir/$dir"
        [ -d "$src" ] || continue
        if [ "$NO_CLOBBER" = true ] && [ -d "$dest" ]; then
            echo "  ~ $dir/ (exists, skipped)"
        else
            backup_if_exists "$dest"
            mkdir -p "$claude_dir"
            cp -r "$src" "$dest"
            echo "  + $dir/"
        fi
    done

    echo ""
    echo "Done."
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
    echo "=== Deploying project configs → $dest ==="
    backup_if_exists "$dest"
    copy_files "$SCRIPT_DIR/project" "$dest"
    echo ""
    echo "Next steps:"
    echo "  1. Edit $dest/CLAUDE.md with your project details"
    echo "  2. Add '.claude/local.md' to .gitignore"
    echo "  3. Commit .claude/CLAUDE.md to git"
    echo ""
    echo "Done."
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
        echo ""
        deploy_project "$PROJECT_PATH"
        ;;
    *)
        usage
        ;;
esac
