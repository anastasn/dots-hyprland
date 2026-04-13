return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },

    config = function()
        local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
            return
        end

        ts_configs.setup({
            ensure_installed = {
                "vimdoc",
                "javascript",
                "typescript",
                "c",
                "lua",
                "rust",
                "jsdoc",
                "bash",
                "python",
            },
            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },

            indent = {
                enable = true,
            },
        })

        -- Add custom parser for templ
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
            filetype = "templ",
        }
    end,
}
