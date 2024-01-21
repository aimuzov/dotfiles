cpu_top=(
	icon.drawing=off
	label.font.style="Semibold"
	label.font.size=7
	label=CPU
	padding_right=8
	width=0
	y_offset=6
)

cpu_percent=(
	label.font.style="Heavy"
	label.font.size=12
	label=CPU
	mach_helper="$HELPER"
	padding_right=8
	update_freq=4
	width=40
	y_offset=-6
)

cpu_sys=(
	background.color=$TRANSPARENT
	background.drawing=on
	background.height=40
	graph.color=$WHITE
	graph.fill_color=$WHITE
	icon.drawing=off
	label.drawing=off
	padding_right=6
	width=0
)

cpu_user=(
	background.color=$TRANSPARENT
	background.drawing=on
	background.height=40
	graph.color=$BLUE
	icon.drawing=off
	label.drawing=off
	padding_right=6
)

sketchybar --add item cpu.top right \
	--set cpu.top "${cpu_top[@]}" \
	\
	--add item cpu.percent right \
	--set cpu.percent "${cpu_percent[@]}" \
	\
	--add graph cpu.sys right 100 \
	--set cpu.sys "${cpu_sys[@]}" \
	\
	--add graph cpu.user right 100 \
	--set cpu.user "${cpu_user[@]}"
