local M = {}

M.lsp_kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    String = " ",
    Struct = "󰆼 ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
}

M.mason_packages = {
    "bash-language-server",
    "css-lsp",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "eslint-lsp",
    "hadolint",
    "html-lsp",
    "intelephense",
    "json-lsp",
    "lua-language-server",
    "markdownlint",
    "nginx-language-server",
    "php-debug-adapter",
    "phpactor",
    "phpstan",
    "prettierd",
    "shellcheck",
    "shfmt",
    "stylua",
}

M.lsp_servers = {
    "tsserver",
    "lua_ls",
    "eslint",
    "bashls",
    "yamlls",
    "jsonls",
    "cssls",
    "html",
    "intelephense",
    "phpactor",
}

M.typo3_lsp = function(lspconfig)
    local configs = require('lspconfig.configs')
    local util = require('lspconfig.util')
    configs.typo3 = {
        default_config = {
            cmd = { '/var/www/bluechip/.devel/lsp.sh' },
            filetypes = '*',
            root_dir = util.root_pattern('typo3_src'),
        },
        docs = {
            description = [[
https://github.com/Teddytrombone/ide-companion
            ]],
            default_config = {
                root_dir = [[util.root_pattern('typo3_src')]],
            }
        }
    }
end

M.php_root_dir = function(pattern)
    local util = require("lspconfig.util")
    local cwd = vim.loop.cwd()
    local root = util.root_pattern("composer.json", ".git")(pattern)

    if root == nil then
        return cwd
    end

    -- prefer cwd if root is a descendant
    return util.path.is_descendant(cwd, root) and cwd or root
end

M.setup = function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
            local bufnr = args.buf

            vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

            local nmap = function(keys, func, desc)
                if desc then
                    desc = "LSP: " .. desc
                end

                vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            nmap("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
            nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
            nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto declaration" })
            -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
            -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Goto implementation" })
            vim.keymap.set(
                "n",
                "<C-k>",
                vim.lsp.buf.signature_help,
                { buffer = bufnr, desc = "Signature documentation" }
            )
            vim.keymap.set(
                "n",
                "<space>wa",
                vim.lsp.buf.add_workspace_folder,
                { buffer = bufnr, desc = "Add workspace folder" }
            )
            vim.keymap.set(
                "n",
                "<space>wr",
                vim.lsp.buf.remove_workspace_folder,
                { buffer = bufnr, desc = "Remove workspace folder" }
            )
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { buffer = bufnr, desc = "List workspace folders" })
            -- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type definition" })
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
            nmap("<leader>ca", function()
                vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
            end, "[C]ode [A]ction")
            -- vim.keymap.set(
            --     { "n", "v" },
            --     "<space>ca",
            --     vim.lsp.buf.code_action,
            --     { buffer = bufnr, desc = "Code actions" }
            -- )
            -- vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({ async = true })
            end, { buffer = bufnr, desc = "Format" })
        end,
    })
end
--
-- local on_attach = function(_, bufnr)
--     -- NOTE: Remember that lua is a real programming language, and as such it is possible
--     -- to define small helper and utility functions so you don't have to repeat yourself
--     -- many times.
--     --
--     -- In this case, we create a function that lets us more easily define mappings specific
--     -- for LSP related items. It sets the mode, buffer and description for us each time.
--     local nmap = function(keys, func, desc)
--         if desc then
--             desc = "LSP: " .. desc
--         end
--
--         vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
--     end
--
--     -- nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
--     nmap("<leader>ca", function()
--         vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
--     end, "[C]ode [A]ction")
--
--     -- nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
--     -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
--     -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
--     -- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
--     -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
--     -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
--     -- See `:help K` for why this keymap
--     -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
--     -- nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
--
--     -- Lesser used LSP functionality
--     nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
--     nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
--     nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
--     nmap("<leader>wl", function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, "[W]orkspace [L]ist Folders")
--
--     -- Create a command `:Format` local to the LSP buffer
--     vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
--         vim.lsp.buf.format()
--     end, { desc = "Format current buffer with LSP" })
-- end

return M
