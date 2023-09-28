vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.cmd [[ set list listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:% ]]
vim.cmd [[ imap <silent><script><expr> <C-J> copilot#Accept("\<CR>") ]]
vim.cmd [[ let g:copilot_no_tab_map = v:true ]]
vim.keymap.set('i', '<c-f>', '<c-g>U<right>', {})
vim.keymap.set('i', '<c-b>', '<c-g>U<left>', {})
vim.keymap.set('i', '<c-p>', '<c-g>U<up>', {})
vim.keymap.set('i', '<c-n>', '<c-g>U<down>', {})
vim.keymap.set('i', '<c-d>', '<c-g>U<del>', {})
vim.cmd [[ inoremap <expr> <c-a> col('.') == match(getline('.'), '\S') + 1 ?
         \ repeat('<C-G>U<Left>', col('.') - 1) :
         \ (col('.') < match(getline('.'), '\S') ?
         \     repeat('<C-G>U<Right>', match(getline('.'), '\S') + 0) :
         \     repeat('<C-G>U<Left>', col('.') - 1 - match(getline('.'), '\S')))]]
vim.cmd [[ inoremap <expr> <c-e> repeat('<C-G>U<Right>', col('$') - col('.')) ]]

function _G.lsp_onattach_func(_, bufnr)
    vim.api.nvim_create_user_command('Implementation', function() vim.lsp.buf.implementation() end, { force = true })
    local bufopts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>r', function() vim.lsp.buf.references({}, nil) end, bufopts)
    vim.api.nvim_create_autocmd('BufWritePre', {
        callback = function() vim.lsp.buf.format { async = false } end,
        buffer = bufnr,
    })
end

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

require("lazy").setup({
    -- completion
    {
        "cohama/lexima.vim",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = { "onsails/lspkind.nvim", "hrsh7th/vim-vsnip" },
        config = function()
            local cmp = require 'cmp'
            local function feedkeys(keys)
                vim.api.nvim_feedkeys(
                    vim.api.nvim_replace_termcodes(keys, true, true, true) or '',
                    '',
                    true
                )
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },
                sources = cmp.config.sources {
                    { name = 'nvim_lsp' },
                    { name = 'vsnip' },
                    { name = 'buffer' },
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'path' },
                },
                formatting = {
                    format = require 'lspkind'.cmp_format {
                        mode = 'symbol_text',
                    }
                },
                mapping = {
                    ['<c-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<c-p>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-e>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.abort()
                        else
                            fallback()
                        end
                    end),
                    ['<tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                            else
                                cmp.confirm()
                            end
                        elseif vim.fn['vsnip#jumpable'](1) == 1 then
                            feedkeys '<Plug>(vsnip-jump-next)'
                        else
                            fallback()
                        end
                    end, { 'i', 's', 'c', }),
                    ['<s-tab>'] = cmp.mapping(function(fallback)
                        if vim.fn['vsnip#jumpable'](-1) == 1 then
                            feedkeys '<Plug>(vsnip-jump-prev)'
                        else
                            fallback()
                        end
                    end, { 'i', 's', 'c', }),
                }
            }
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources {
                    { name = 'cmdline' },
                }
            })
            for _, c in pairs { '/', '?' } do
                cmp.setup.cmdline(c, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources {
                        { name = 'buffer' },
                    }
                })
            end
        end
    },
    { 'hrsh7th/cmp-vsnip', dependencies = 'hrsh7th/nvim-cmp', event = 'InsertCharPre' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help', dependencies = 'hrsh7th/nvim-cmp', event = 'InsertCharPre' },
    { 'hrsh7th/cmp-cmdline', dependencies = 'hrsh7th/nvim-cmp', event = 'CmdlineEnter' },
    { 'hrsh7th/cmp-path', dependencies = 'hrsh7th/nvim-cmp', event = 'InsertCharPre' },
    { 'hrsh7th/cmp-buffer', dependencies = 'hrsh7th/nvim-cmp', event = { 'InsertCharPre', 'CmdlineEnter' } },
    {
        "github/copilot.vim",
    },

    -- ui
    {
        "navarasu/onedark.nvim",
        config = function()
            require "onedark".setup()
            require "onedark".load()
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim', -- インデントの可視化
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        config = function()
            vim.opt.list = true
            vim.api.nvim_set_var('indent_blankline_indent_level', 4)
            vim.api.nvim_set_var('indent_blankline_use_treesitter', true)
            require 'indent_blankline'.setup {
                space_char_blankline = ' ',
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
    },
    {
        'lewis6991/gitsigns.nvim', -- Gitの行毎ステータス
        event = 'VeryLazy',
        config = {
            numhl = true,
            -- signcolumn = false,
        }
    },
    'lambdalisue/nerdfont.vim',
    {
        'lambdalisue/fern.vim',
        dependencies = 'lambdalisue/fern-renderer-nerdfont.vim',
        config = function()
            vim.api.nvim_set_var("fern#renderer", "nerdfont")
            vim.api.nvim_set_var("fern#renderer#nerdfont#indent_markers", 1)
            vim.keymap.set('n', '<C-n>', '<cmd>Fern . -drawer -toggle -reveal=% <cr>')
        end
    },
    {
        'lambdalisue/fern-hijack.vim',
        dependencies = 'lambdalisue/fern.vim',
    },
    {
        'lambdalisue/fern-git-status.vim',
        dependencies = 'lambdalisue/fern.vim',
    },
    {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        requires = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = 'none',
                    number_style = 'superscript',
                    mappings = true,
                    buffer_close_icon = '',
                    modified_icon = '',
                    close_icon = '',
                    left_trunc_marker = '',
                    right_trunc_marker = '',
                    max_name_length = 18,
                    max_prefix_length = 15,
                    tab_size = 18,
                    diagnostics = 'nvim_lsp',
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local s = ' '
                        for e, n in pairs(diagnostics_dict) do
                            local sym = e == 'error' and ' '
                                or (e == 'warning' and ' ' or '')
                            s = s .. n .. sym
                        end
                        return s
                    end,
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    show_tab_indicators = true,
                    persist_buffer_sort = true,
                    separator_style = 'thin',
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    sort_by = 'id',
                }
            }
        end
    },

    -- tools
    {
        'numToStr/Comment.nvim', -- コメントのトグル
        config = true,
    },
    {
        'nvim-treesitter/nvim-treesitter', -- Treesitter
        config = function()
            local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'
            vim.opt.runtimepath:append(vim.fn.stdpath 'data' .. '/treesitter')
            require 'nvim-treesitter.configs'.setup {
                parser_install_dir = parser_install_dir,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                auto_install = true,
            }
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
            vim.wo.foldenable = false
            vim.wo.foldlevel = 999
        end
    },
    {
        'williamboman/mason.nvim', -- LSP Installer
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'neovim/nvim-lspconfig',
            {
                "folke/neodev.nvim",
                ft = 'lua',
                config = {
                    override = function(_, library)
                        library.enabled = true
                        library.plugins = true
                    end,
                },
            },
        },
        event = 'VeryLazy',
        config = function()
            require 'mason'.setup {}
            local mason_lspconfig = require 'mason-lspconfig'
            local capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
            mason_lspconfig.setup_handlers { function(server_name)
                local opts = {
                    capabilities = capabilities,
                    on_attach = function(i, bufnr)
                        vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:250})')
                        _G.lsp_onattach_func(i, bufnr)

                    end,
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                            },
                            completion = {
                                callSnippet = "Replace"
                            },
                        },
                        ['rust-analyzer'] = {
                            checkOnSave = {
                                command = 'clippy',
                            },
                        },
                    }
                }
                require 'lspconfig'[server_name].setup(opts)
            end }
            vim.cmd 'LspStart' -- 初回起動時はBufEnterが発火しない
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        event = 'VeryLazy',
        dependencies = { 'williamboman/mason.nvim', 'nvim-lua/plenary.nvim' },
        config = function()
            local mason = require 'mason'
            local mason_package = require 'mason-core.package'
            local mason_registry = require 'mason-registry'
            local null_ls = require 'null-ls'
            mason.setup {}
            local null_sources = {}
            for _, package in ipairs(mason_registry.get_installed_packages()) do
                local package_categories = package.spec.categories[1]
                if package_categories == mason_package.Cat.Formatter then
                    table.insert(null_sources, null_ls.builtins.formatting[package.name])
                elseif package_categories == mason_package.Cat.Linter then
                    table.insert(null_sources, null_ls.builtins.diagnostics[package.name])
                end
            end
            null_ls.setup {
                sources = null_sources,
                on_attach = _G.lsp_onattach_func,
            }
        end
    },
    {
        "tpope/vim-fugitive",
    },
})
