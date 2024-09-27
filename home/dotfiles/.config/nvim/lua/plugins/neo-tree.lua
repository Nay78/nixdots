return {
   "nvim-neo-tree/neo-tree.nvim",
   opts = {
      window = {
         position = "right",
         mappings = {
          ["<Right>"] = "open",
          ["<Left>"] = "close_node"
         },
      },
      filesystem = {
         filtered_items = { 
        visible = true

      },
      },
   },
}
