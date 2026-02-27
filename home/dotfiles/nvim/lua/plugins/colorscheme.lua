return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    name = "kanagawa",
    config = function()
        require("kanagawa").load("dragon")
    end,
}

