-- can see try/init.lua for various things
-- below is my actual config as is now

-- TODO: hide status bar on bottom
-- TODO: remove line numbers
-- TODO: get ghostty theme that is github theme like in cursor. same for neovim (should be identical)
-- TODO: bind to reload current nvim editor instance from config. to fast iterate

-- remove line numbers on side
vim.opt.number = false

-- hide ~ ~ on non used lines
vim.opt.fillchars:append({ eob = " " })

-- save and reload nvim config or just save
vim.keymap.set('n', '<Space>w', function()
  -- Save the current file
  vim.cmd('write')

  -- Get the current file name
  local current_file = vim.fn.expand('%:t')

  -- Source the config only if we're in init.lua
  if current_file == 'init.lua' then
      vim.cmd('source $MYVIMRC')
  end
end, { noremap = true, silent = true })

-- remove status bar on bottom
vim.opt.laststatus = 0
vim.opt.statusline = ""
vim.opt.cmdheight = 0

-- make y copy to system clipboard
vim.opt.clipboard = "unnamedplus"
