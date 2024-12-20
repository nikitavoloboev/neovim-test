local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()
for k, v in pairs(cmp_capabilities) do
    capabilities[k] = v
end

vim.lsp.set_log_level("OFF")

vim.api.nvim_create_autocmd(
    {'LspAttach'},
    {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            vim.keymap.set(
                'n',
                'K',
                vim.lsp.buf.hover,
                {
                    buffer = args.buf
                }
            )
            vim.keymap.set(
                'n',
                'gd',
                vim.lsp.buf.definition,
                {
                    buffer = args.buf
                }
            )

            if client.name == 'clangd' then
                vim.keymap.set(
                    'n',
                    '<leader>of',
                    function()
                        client.request(
                            'textDocument/switchSourceHeader',
                            {
                                uri = vim.uri_from_bufnr(args.buf)
                            },
                            function (err, result)
                                if err then
                                    error(tostring(err))
                                end

                                if result then
                                    vim.api.nvim_command('edit' .. vim.uri_to_fname(result))
                                else
                                    print('Cannot file target file')
                                end
                            end,
                            args.buf
                        )
                    end,
                    {
                        buffer = args.buf
                    }
                )
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'c', 'cpp'},
        callback = function(args)
            if vim.fn.executable('clangd') == 1 then
                vim.lsp.start({
                    name = 'clangd',
                    cmd = {
                        'clangd',
                        '-j',
                        '4',
                        '--background-index=true',
                        '--clang-tidy',
                        '--header-insertion=never'
                    },
                    root_dir = vim.fs.dirname(
                        vim.fs.find(
                            'compile_commands.json',
                            {
                                upward = true
                            }
                        )[1]
                    ),
                    capabilities = capabilities
                })
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'go'},
        callback = function(args)
            if vim.fn.executable('gopls') == 1 then
                vim.lsp.start({
                    name = 'gopls',
                    cmd = {
                        'gopls'
                    },
                    root_dir = vim.fs.dirname(
                        vim.fs.find(
                            'go.mod',
                            {
                                upward = true
                            }
                        )[1]
                    ),
                    capabilities = vim.lsp.protocol.make_client_capabilities()
                })
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'arduino'},
        callback = function(args)
            if vim.fn.executable('arduino-language-server') == 1 then
                local default_fqbn = "arduino:avr:nano"
                -- TODO parse fqbr from .k-tool file
                vim.lsp.start({
                    name = 'arduino-language-server',
                    cmd = {
                        'arduino-language-server',
                        '-fqbn',
                        default_fqbn
                    },
                    capabilities = capabilities,
                    root_dir = vim.fn.getcwd()
                })
            end
        end
    }
)
vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'python'},
        callback = function(args)
            if vim.fn.executable('pylsp') == 1 then
                local arc_path = vim.fs.dirname(
                    vim.fs.find(
                        '.arcadia.root',
                        {
                            upward = true,
                        }
                    )[1]
                )

                if arc_path then
                    vim.lsp.start({
                        name = 'pylsp',
                        cmd = {
                            'pylsp'
                        },
                        root_dir = arc_path,
                        capabilities = capabilities,
                        settings = {
                            pylsp = {
                                plugins = {
                                    jedi = {
                                        extra_paths = {
                                            arc_path .. '/contrib/python',
                                            arc_path .. '/library/python/testing/yatest_common'
                                        }
                                    }
                                }
                            }
                        },
                    })
                else
                    vim.lsp.start({
                        name = 'pylsp',
                        cmd = {
                            'pylsp'
                        },
                        root_dir = vim.fn.getcwd(),
                        capabilities = capabilities
                    })
                end
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'javascript', 'javascriptreact', 'typescript'},
        callback = function(args)
            if vim.fn.executable('typescript-language-server') == 1 then
                vim.lsp.start({
                    name = 'tsserver',
                    cmd = {
                        'typescript-language-server',
                        '--stdio'
                    },
                    root_dir = vim.fs.dirname(
                        vim.fs.find(
                            'package.json',
                            {
                                upward = true
                            }
                        )[1]
                    ),
                    capabilities = capabilities
                })
            end
        end
    }
)


vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'lua'},
        callback = function(args)
            if vim.fn.executable('lua-language-server') == 1 then
                local apphost_config_path = vim.fs.find(
                    {
                        'config.yaml',
                        'config.yml'
                    },
                    {
                        upward = true
                    }
                )[1]

                local nvim_config = vim.fs.find(
                    function(name, path)
                        return name == 'init.lua' and path:find('.config/nvim')
                    end,
                    {
                        upward = true
                    }
                )

                if apphost_config_path ~= nil then
                    vim.lsp.start({
                        name = 'lua-language-server',
                        cmd_env = {
                            ARCADIA_ROOT = '/home/k-vukolov/arc/arcadia'
                        },
                        cmd = {
                            '/home/k-vukolov/arc/arcadia/apphost/gp/tools/lsp/lsp',
                            apphost_config_path,
                            '-l',
                            '/home/k-vukolov/lsp.log'
                        },
                        capabilities = capabilities,
                    })
                elseif nvim_config ~= nil then
                    vim.lsp.start({
                        name = 'lua-language-server',
                        cmd = {
                            'lua-language-server',
                        },
                        settings = {
                            Lua = {
                                workspace = {
                                    library = {
                                        vim.env.VIMRUNTIME
                                    }
                                }
                            }
                        }
                    })
                end
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'yamake'},
        callback = function(args)
            if vim.fn.executable('node') == 1 then
                local script_path = '/home/k-vukolov/arc/arcadia/devtools/ide/vscode-yandex-arc/ya-make-lsp/out/src/ya-make-lsp.js'
                if vim.fn.filereadable(script_path) then
                    vim.lsp.start({
                        name = 'yamake-lsp',
                        cmd = {
                            'node',
                            script_path,
                            '--stdio'
                        },
                        capabilities = capabilities,
                    })
                end
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {'FileType'},
    {
        pattern = {'nix'},
        callback = function(args)
            if vim.fn.executable('nil') == 1 then
                vim.lsp.start({
                    name = 'nil',
                    cmd = {
                        'nil',
                    },
                    capabilities = capabilities,
                    settings = {
                        ['nil'] = {
                            nix = {
                                flake = {
                                    autoArchive = true
                                }
                            }
                        }
                    }
                })
            end
        end
    }
)
