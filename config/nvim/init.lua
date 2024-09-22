
vim.cmd([[
  if filereadable(glob("~/.vimrc"))
    source ~/.vimrc
  endif
]])
-- Bootstrap lazy.nvim plugin manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Source basic settings.
require("settings")

-- Source plugins.
require("lazy").setup("plugins")

-- Source custom configs (not under version control).
vim.cmd([[
  if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
]])