function exists(path)
	f = io.open(path, "r")
	if f ~= nil then io.close(f) return true else return false end
end

local plug_dir = vim.fn.stdpath('data') .. '/site/autoload/plug.vim'

if exists(plug_dir) ~= true then
	local f = io.popen('curl -fLo ' .. plug_dir .. ' --create-dirs ' .. 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	f:read('*all')
end
local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'arkav/lualine-lsp-progress'

    -- Nix file highlight
    Plug 'LnL7/vim-nix'

    -- Colorscheme
    Plug 'arzg/vim-colors-xcode'
    Plug 'EdenEast/nightfox.nvim'

    -- Notes
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-notes'

    Plug 'ryanoasis/vim-devicons'

    Plug 'tpope/vim-surround'

    Plug 'jiangmiao/auto-pairs'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'lukas-reineke/indent-blankline.nvim'

    if vim.fn.hostname() ~= 'k-vukolov-wsl' then
        Plug 'is0n/fm-nvim'
    end

    Plug 'petertriho/nvim-scrollbar'

    -- Autocompletion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'FelipeLema/cmp-async-path'

    Plug 'onsails/lspkind.nvim'

    Plug 'xiyaowong/transparent.nvim'

    Plug(
        'iamcco/markdown-preview.nvim',
        {
            ['do'] = 'cd app && yarn install'
        }
    )

    local arcblamer_path = '/home/k-vukolov/arc/arcadia/junk/magnickolas/arcblamer.nvim'
    if exists(arcblamer_path .. '/README.md') then
        Plug(arcblamer_path)
    end

    Plug 'weilbith/nvim-code-action-menu'

    Plug 'sakhnik/nvim-gdb'
vim.call('plug#end')
