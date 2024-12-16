## -- WEBOS ------------------------------------------------------------------------------------------------------------

# https://webostv.developer.lge.com/develop/tools/cli-installation
export LG_WEBOS_TV_SDK_HOME="$HOME/stv-tools/webos-sdk"
export WEBOS_CLI_TV="$LG_WEBOS_TV_SDK_HOME/bin"

PATH="$WEBOS_CLI_TV:$PATH"

## -- TIZEN ------------------------------------------------------------------------------------------------------------

export SAMSUNG_TIZEN_SDK_HOME="$HOME/stv-tools/tizen-studio"
export TIZEN_CLI_TV="$SAMSUNG_TIZEN_SDK_HOME/tools/ide/bin"

PATH="$TIZEN_CLI_TV:$PATH"
