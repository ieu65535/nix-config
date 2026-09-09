return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function ()
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        })
        vim.lsp.enable("lua_ls")
        -- vim.lsp.enable("nil_ls")
        vim.lsp.enable("nixd")
        vim.diagnostic.config({
            virtual_text = true,
        })
    end
}
