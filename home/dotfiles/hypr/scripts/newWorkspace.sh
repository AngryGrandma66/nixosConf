#!/usr/bin/env bash

# Get current workspace and used workspaces
current_ws=$(hyprctl activeworkspace -j | jq -r '.id')
used_ws=$(hyprctl workspaces -j | jq '.[].id' | sort -n)

# Check if current workspace is empty
is_current_empty=$(hyprctl clients -j | jq --argjson ws "$current_ws" '[.[] | select(.workspace.id == $ws)] | length == 0')

if [ "$is_current_empty" = "true" ]; then
    # Do nothing if current workspace has no windows
    exit 0
fi

# Function: check if workspace is empty
is_empty() {
    local ws=$1
    if ! echo "$used_ws" | grep -qx "$ws"; then
        return 0  # empty
    fi
    return 1  # occupied
}

# Function: switch and exit
switch_to() {
    hyprctl dispatch workspace "$1"
    exit 0
}

# Generate candidate workspace list
generate_candidates() {
    local cur=$1
    local candidates=()

    if (( cur < 5 )); then
        # Case A: prefer upward first, then alternate
        for offset in $(seq 1 9); do
            up=$((cur + offset))
            down=$((cur - offset))
            ((up <= 10)) && candidates+=("$up")
            ((down >= 1)) && candidates+=("$down")
        done
    elif (( cur <= 10 )); then
        # Case CD: prefer downward first, then alternate upward
        for offset in $(seq 1 9); do
            down=$((cur - offset))
            up=$((cur + offset))
            ((down >= 1)) && candidates+=("$down")
            ((up <= 10)) && candidates+=("$up")
        done
    else
        # Case E: above 10, just go to next
        next=$((cur + 1))
        echo "$next"
        return
    fi

    printf '%s\n' "${candidates[@]}" | awk '!seen[$0]++'  # unique list
}

# Main logic
candidates=$(generate_candidates "$current_ws")

for ws in $candidates; do
    is_empty "$ws" && switch_to "$ws"
done

# Fallback: all 1–10 occupied → find next available above 10
next_ws=11
while ! is_empty "$next_ws"; do
    ((next_ws++))
done
switch_to "$next_ws"

