#!/usr/bin/env bash
# from: https://github.com/jesseduffield/lazygit/issues/3052#issuecomment-1783735606
#
# when calling open, provided by OS, any escape character
# is escaped again
# in case of Lazygit, we replace the %2F character with '/'
# and let 'open' command do it's job escaping any character
# that could be problematic when opened in a web browser
URL="$1"
if [[ -z ${URL} ]]; then
	echo "no URL given"
	exit 1
fi

CLEAN_URL=$(echo "${URL}" | sed -e 's/%2F/\//g')

if ! open "${CLEAN_URL}"; then
	echo "failed to open >${URL}<"
	exit 1
fi
exit 0
