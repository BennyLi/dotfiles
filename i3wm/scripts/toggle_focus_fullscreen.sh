i3-msg -t get_tree | jq -e 'recurse(.nodes[]; .nodes) | select(.focused)'
