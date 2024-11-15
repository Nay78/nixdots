return {
  "nvim-treesitter/nvim-treesitter",
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<bs>",
        node_incremental = "<bs>",
        scope_incremental = false,
        node_decremental = "<C-space>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["<M-f>"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["<M-c>"] = "@class.outer",
          ["]a"] = "@parameter.inner",
          ["<M-a>"] = "@parameter.inner",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.inner",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.inner",
          ["<M-F>"] = "@function.outer",
          ["<M-C>"] = "@class.outer",
          ["<M-A>"] = "@parameter.inner",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.inner",
        },
      },
    },
  },
}
