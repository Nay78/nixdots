return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup({
      -- WARN:TODO: unsecure
      -- api_key_cmd = "echo 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",
      -- this config assumes you have OPENAI_API_KEY environment variable set
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim", -- optional
    "nvim-telescope/telescope.nvim",
  },
}
