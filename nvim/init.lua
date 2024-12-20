require('plugins')

require("nightfox").setup({
    specs = {
        all = {
            syntax = {
                builtin0 = "magenta.base"
            }
        }
    }
})

-- TODO:
-- let mapleader=" "
-- let maplocalleader=" "

vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd 'colorscheme nightfox'

vim.g.code_action_menu_window_border = 'rounded'
vim.g.code_action_menu_show_details = false

vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {
            'ya.make',
            'ya.make.inc'
            -- foobar
        },
        callback = function()
            vim.o.filetype = 'yamake'
        end
    }
)

vim.api.nvim_create_autocmd(
    {"BufRead", "BufNewFile"},
    {
        pattern = {
            '*.pb.txt',
        },
        callback = function()
            vim.o.filetype = 'pbtxt'
        end
    }
)

vim.o.ruler = true
vim.o.showtabline = 1
vim.o.backspace = 'indent,eol,start'
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.encoding='utf8'
vim.o.wildmenu = true
vim.o.incsearch = true
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.exrc = true
if vim.fn.hostname() ~= "k-vukolov-wsl" then
    vim.o.clipboard = 'unnamed'
end
vim.o.showcmd = true
vim.o.signcolumn = 'yes'
vim.o.hlsearch = false
vim.o.pumheight = 15
vim.o.langmap = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz'

require('keybindings')

require('ibl').setup {
}

require("scrollbar").setup()

require('lsp')

require('lualine').setup({
    options = {
        theme = 'auto'
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1
            },
            'lsp_progress'
        }
    }
})

vim.keymap.set(
    'n',
    '<C-l>',
    function()
        require('telescope.builtin').find_files()
    end,
    {
        silent = true
    }
)

local cmp = require('cmp')

cmp.setup({
    enabled = true,
    sources = {
        {
            name = 'nvim_lsp',
        },
        {
            name = 'async_path',
        }
    },
    window = {
        completion = {
            scrollbar = true,
            border = "rounded"
        }
    },
    formatting = {
        format = require('lspkind').cmp_format()
    },
    mapping = {
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.complete(),
        ['<Enter>'] = cmp.mapping.confirm(),
    }
})