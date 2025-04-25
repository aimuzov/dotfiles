load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()
require("lazy.minit").repro({ spec = { { "aimuzov/LazyVimx", branch = "develop", import = "lazyvimx.boot" } } })
