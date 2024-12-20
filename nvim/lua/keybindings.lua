vim.keymap.set(
    'n',
    'fb',
    function()
        require('telescope.builtin').buffers()
    end,
    {
        silent = true
    }
)

vim.keymap.set(
    'n',
    'fd',
    function()
        require('telescope.builtin').diagnostics()
    end,
    {
        silent = true
    }
)

vim.keymap.set(
    'n',
    'fa',
    function()
        vim.cmd('CodeActionMenu')
    end,
    {
        silent = true
    }
)

vim.keymap.set(
    'n',
    'fs',
    function()
        require('telescope.builtin').lsp_document_symbols()
    end,
    {
        silent = true
    }
)
