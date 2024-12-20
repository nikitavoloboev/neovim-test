-- remove line numbers on side
vim.opt.number = false

-- hide ~ ~ on non used lines
vim.opt.fillchars:append({ eob = " " })

-- save and reload nvim config (if saving `init.lua` or just save)
-- TODO: prob should consider full path
vim.keymap.set('n', '<Space>w', function()
  -- save current file
  vim.cmd('write')

  -- get current file name
  local current_file = vim.fn.expand('%:t')

  -- source config only if we're in init.lua
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
