#!/usr/bin/env python3

import subprocess


result = subprocess.run("swaymsg", "-t", "get_tree", capture_output=True, text=True)

print(result.stdout)

# swaymsg -t get_tree | jq -r '
#         # descend to workspace or scratchpad
#         .nodes[].nodes[]
#         # save workspace name as .w
#         | {"w": .name} + (
#                 if .nodes then # workspace
#                         [recurse(.nodes[])]
#                 else # scratchpad
#                         []
#                 end
#                 + .floating_nodes
#                 | .[]
#                 # select nodes with no children (windows)
#                 | select(.nodes==[])
#         )
#         | ((.id | tostring) + "\t "
#         # remove markup and index from workspace name, replace scratch with "[S]"
#         + "\t " +  .name)
#         + (.w | gsub("^[^:]*:|<[^>]*>"; "") | sub("__i3_scratch"; "[S]"))
#         ' | wofi --show dmenu --prompt='Focus a window' | {
#     read -r id name
#     swaymsg "[con_id=$id]" focus
# }
