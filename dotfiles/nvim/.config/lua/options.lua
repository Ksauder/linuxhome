-- [[ Setting options ]] See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:help option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

-- vim.o.nocompatible = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.mouse = "v"
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.autoindent = true
-- Print the line number in front of each line
vim.o.number = true
-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
-- option above, see `:h number_relativenumber`
vim.o.relativenumber = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
-- Highlight the line where the cursor is on
vim.o.wildmode = "longest,list"
vim.o.cursorline = true
vim.o.cc = "120"
vim.o.mouse = "a"
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Show <tab> and trailing spaces
vim.o.list = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
--     vim.o.clipboard = 'unnamedplus'
--   end,
-- })

