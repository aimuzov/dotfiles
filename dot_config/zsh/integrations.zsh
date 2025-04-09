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
	'vscode'
)

source "$ZSH/plugins/zsh-defer/zsh-defer.plugin.zsh"

for name in $integrations; do
	source "$ZSH/integrations/$name.zsh"
done
