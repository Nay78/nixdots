-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- set tabstop=4
vim.opt.tabstop = 4
vim.opt.scrolloff = 22
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append("$")
vim.opt.iskeyword:append(":")
