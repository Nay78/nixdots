return {
  "nvim-neo-tree/neo-tree.nvim",
  -- filter = {
  --   event = "notify",
  --   kind = "info",
  --   any = {
  --     { find = "hidden" },
  --   },
  -- },
  opts = {
    window = {
      -- position = "right",
      mappings = {
        ["<Right>"] = "open",
        ["<Left>"] = "close_node",
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
  },
}
