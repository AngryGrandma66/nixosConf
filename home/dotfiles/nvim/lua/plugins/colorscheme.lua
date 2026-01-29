return {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    name = "nord",
    config = function()
        require("nord").set()
        vim.cmd("colorscheme nord")
    end,
}

