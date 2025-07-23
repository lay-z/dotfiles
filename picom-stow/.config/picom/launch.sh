#!/usr/bin/bash

# killall ornfelt-picom
# ornfelt-picom \
# 	--animations \
# 	--animation-for-open-window=fly-in \
# 	--animation-for-open-window=fly-in \
# 	--experimental-backends \
# 	--config ~/.config/picom/picom.conf \
# 	-b

killall picom
picom \
  -b
	# --config ~/.config/picom/picom.conf \
	# --experimental-backends \
	# --animations \
	# --animation-for-open-window=fly-in \
	# --animation-for-workspace-switch-in=fly-in \
	# -b \
	# --experimental-backends \
	# --animation-for-workspace-switch-in=fly-in \
