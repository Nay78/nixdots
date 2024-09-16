return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
{
        "<C-j>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(1)
        end,
        desc = "Harpoon to file 1",
      },
{
        "<C-l>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(2)
        end,
        desc = "Harpoon to file 2",
      },
{
        "<C-k>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(3)
        end,
        desc = "Harpoon to file 3",
      },
{

        "<C-h>",
        function()
          local harpoon = require("harpoon")
          harpoon:list():select(4)
        end,
        desc = "Harpoon to file 4",
      },

    }

    -- for i = 1, 5 do
    --   table.insert(keys, {
    --     "<leader>" ..  i,
    --     function()
    --       require("harpoon"):list():select(i)
    --     end,
    --     desc = "Harpoon to File " .. i,
    --   })
    -- end
    return keys
  end,
}
