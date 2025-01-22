integrations=(
	'shell'
	# 'vi-mode'
	'stv-tools'
	'cmd'
	'deps-management'
	'dir-listing'
	'file-listing'
	'git'
	'lang'
)

source "$ZSH/plugins/zsh-defer/zsh-defer.plugin.zsh"

for name in $integrations; do
	source "$ZSH/integrations/$name.zsh"
done
