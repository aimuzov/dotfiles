#!/bin/bash

cpu_top=(
	label.font="$FONT:Semibold:7"
	label=CPU
	icon.drawing=off
	width=0
	padding_right=8
	y_offset=6
)

cpu_percent=(
	label.font="$FONT:Heavy:12"
	label=CPU
	y_offset=-6
	padding_right=8
	width=40
	update_freq=4
	mach_helper="$HELPER"
)

cpu_sys=(
	width=0
	graph.color=$RED
	graph.fill_color=$RED
	label.drawing=off
	icon.drawing=off
	background.height=30
	background.drawing=on
	background.color=$TRANSPARENT
)

cpu_user=(
	graph.color=$BLUE
	label.drawing=off
	icon.drawing=off
	background.height=30
	background.drawing=on
	background.color=$TRANSPARENT
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
