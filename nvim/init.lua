-- can see try/init.lua for various things
-- below is my actual config as is now

-- TODO: hide status bar on bottom
-- TODO: remove line numbers
-- TODO: get ghostty theme that is github theme like in cursor. same for neovim (should be identical)
-- TODO: bind to reload current nvim editor instance from config. to fast iterate

-- remove line numbers on side
vim.opt.number = false

-- remove status bar on bottom
vim.opt.laststatus = 0

-- hide ~ ~ on non used lines
vim.opt.fillchars:append({ eob = " " })

-- reload config with space+f
vim.keymap.set('n', '<Space>w', ':w<CR>:source $MYVIMRC<CR>', { noremap = true, silent = true })
